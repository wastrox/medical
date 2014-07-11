# encoding: utf-8

class Scope < ActiveRecord::Base
  attr_accessible :title, :description, :categories_attributes, :cover, :morpher_id
  has_attached_file :cover, :styles => { :index => "300x210>" }

  has_many :vacancies
  has_one  :company
  has_many :categories, :dependent => :destroy 
    accepts_nested_attributes_for :categories, :allow_destroy => true

  belongs_to :morpher

  before_save :case_morphology
  before_save :init_description

  validates :title, presence: true

  def singular(padeg)
    begin
      self.morpher.case[padeg.to_sym] if check_case     
    rescue Exception => e
      self.title
    end
  end

  def plural(padeg)
    begin
      self.morpher.case[:множественное][padeg.to_sym] if check_case
    rescue Exception => e
      self.title
    end
  end

  private

  	def case_morphology
  		str = self.title
  		morpher = MorpherControl.new
	  	result = morpher.push(str, self.morpher_id)
	  	result ? self.morpher_id = result : false
  	end

    def init_description
      self.description = "" if self.description.nil?
    end

    def check_case
      self.title == self.morpher.case[:И]
    end
end
