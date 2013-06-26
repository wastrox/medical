class Scope < ActiveRecord::Base
  attr_accessible :title

  has_one :company

end
