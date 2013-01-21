class CompanyContact < ActiveRecord::Base
  belongs_to :company
  attr_accessible :name, :phone
end
