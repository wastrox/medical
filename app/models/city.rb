# encoding: utf-8

class City < ActiveRecord::Base
  attr_accessible :name, :morpher_id

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
