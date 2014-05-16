# encoding: utf-8

class Category < ActiveRecord::Base
  attr_accessible :name, :description, :cover, :morpher_id
  has_attached_file :cover, :styles => { :index => "300x210>" }
  
  has_many :vacancies
  belongs_to :scope

  belongs_to :morpher

    before_save :case_morphology

  private

  	def case_morphology
  		str = self.name
  		morpher = MorpherControl.new
	  	result = morpher.push(str, self.morpher_id)
	  	result ? self.morpher_id = result : false
  	end

	def singular(padeg)
		self.morpher.case[padeg.to_sym]
	end

	def plural(padeg)
		self.morpher.case[:множественное][padeg.to_sym]
	end
end
