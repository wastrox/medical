class Scope < ActiveRecord::Base
  attr_accessible :title, :description, :categories_attributes

  has_many :vacancies
  has_one  :company
  has_many :categories, :dependent => :destroy 
    accepts_nested_attributes_for :categories, :allow_destroy => true

end
