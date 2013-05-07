class CompanyContact < ActiveRecord::Base
  attr_accessible :name, :phone

  belongs_to :company
  has_many :vacancies

  validates_presence_of :name, :phone
end
