class Article < ActiveRecord::Base
  attr_accessible :body, :cover, :description, :published_at, :title
  has_attached_file :cover, :styles => { :index => "300x210>" }

  validates_presence_of :title, :body, :cover

  before_create :publicated_at
  after_destroy :appoint_DefaultArticle_if_no_such

  	state_machine :state, :initial => :published do
      before_transition [:default, :published] => :archive, :do => :will_not_be_published
      after_transition [:default, :published] => :archive, :do => :appoint_DefaultArticle_if_no_such
      before_transition [:published, :archive] => :default, :do => :publicated_at
      before_transition [:default, :archive] => :published, :do => :publicated_at

      event :published do
        transition [:default, :archive] => :published
      end

      event :default do
      	transition [:published, :archive] => :default
      end
      
      event :archive do
        transition [:default, :published] => :archive
      end
    end

    def defaultArticle(params_value)
      if params_value == "true" 
        self.default
      else
        self.published
      end
    end

    protected

    def publicated_at
      self.published_at = Time.now
    end

    def will_not_be_published
      self.published_at = nil
    end

    def find_defaultArticle
      Article.where(state: "default")
    end

    def appoint_DefaultArticle_if_no_such
      articles = find_defaultArticle
      if articles.empty?
        Article.last.default
      end
    end
end
