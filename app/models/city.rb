# encoding: utf-8

class City < ActiveRecord::Base
  attr_accessible :name, :morpher_id

  belongs_to :morpher

    before_save :case_morphology

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
