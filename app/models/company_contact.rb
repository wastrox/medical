class CompanyContact < ActiveRecord::Base
  belongs_to :company
  has_many :vacancies
  attr_accessible :name, :phone
end
