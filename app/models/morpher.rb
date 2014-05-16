# encoding: utf-8

class Morpher < ActiveRecord::Base
  serialize :case, Hash
  has_one :scope
  has_one :category
  has_one :city

  def singular(padeg)
    self.case[padeg.to_sym]
  end
  
  def plural(padeg)
    self.case[:множественное][padeg.to_sym]
  end
end
