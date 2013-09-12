class Category < ActiveRecord::Base
  attr_accessible :name, :description
  
  has_many :vacancies
  belongs_to :scope

end
