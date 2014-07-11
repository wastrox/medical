# encoding: utf-8

class Category < ActiveRecord::Base
  attr_accessible :name, :description, :cover, :morpher_id
  has_attached_file :cover, :styles => { :index => "300x210>" }
  
  has_many :vacancies
  belongs_to :scope

  belongs_to :morpher
  
  before_save :init_description
  before_save :case_morphology

  validates :name, presence: true

  def singular(padeg)
    begin
      self.morpher.case[padeg.to_sym] if check_case     
    rescue Exception => e
      self.name
    end
  end

  def plural(padeg)
    begin
      self.morpher.case[:множественное][padeg.to_sym] if check_case
    rescue Exception => e
      self.name
    end
  end

  private

  def init_description
    self.description = "" if self.description.nil?
  end

	def case_morphology
		str = self.name
		morpher = MorpherControl.new
  	result = morpher.push(str, self.morpher_id)
  	result ? self.morpher_id = result : false
	end

  def check_case
    self.name == self.morpher.case[:И]
  end
end
