class Company < ActiveRecord::Base
  attr_accessible :logo, :description, :name, :scope, :site, :company_contacts_attributes, :scope_id

  before_create :check_link_company
  before_update :check_link_company

	has_attached_file :logo, :styles => { :small => "80x109>", :search => "40x38", :vip => "160x90" }, :default_url => "/assets/paperclip/missing_logo_:style.png"

  validates_presence_of :description, :name, :scope

  belongs_to :employer, :dependent => :destroy 
  belongs_to :scope

  has_many :vacancies, :dependent => :destroy  
  has_many :company_contacts, :dependent => :destroy 
    accepts_nested_attributes_for :company_contacts, :allow_destroy => true
    
    state_machine :state, :initial => :draft do

      # после реиндексации delta устанавливается в false для всего контента - так как он проиндексирован.
      # перед любым изменением состояния требуем переиндексировать контект по окончанию изменения состояния с помощью дельта-индексирования
      # http://stackoverflow.com/questions/4094982/rails-thinking-sphinx-how-do-i-set-delta-to-true-after-reindexing
      # Thinking Sphinx должен сам устанавливать delta=true после изменения данных в экземпляре класса, но используемая версия этого не делает.
      # Возможно, это баг используемой версии Thinking Sphinx. Фикс ниже - это временный work-around для этой проблемы.
      before_transition any => any do |content, transition|
        content.delta = true
      end
      
      event :request do
        transition :draft => :pending
      end

      event :approve_published do
        transition [:pending, :vip, :rejected] => :published
      end

      event :approve_vip do
        transition [:pending, :published] => :vip
      end

      event :approve_rejected do
        transition [:pending, :published, :vip] => :rejected
      end

      event :edit do
        transition [:published, :vip, :rejected, :draft] => :pending
      end
    end

    def to_param
      company_name = Russian.translit(name)
      "#{id}-#{company_name.parameterize}"
    end

    private

    def check_link_company
      str = self.site
      self.site = str.sub(%r(https?://), '').sub(%r((\/*)$), '')
    end
end
