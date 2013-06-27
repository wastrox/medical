class Category < ActiveRecord::Base
  attr_accessible :name
  
  has_many :vacancies
  belongs_to :scope

end
