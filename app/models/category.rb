class Category < ActiveRecord::Base
  attr_accessible :name, :description, :cover
  has_attached_file :cover, :styles => { :index => "300x210>" }
  
  has_many :vacancies
  belongs_to :scope

end
