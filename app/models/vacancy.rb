class Vacancy < ActiveRecord::Base
  belongs_to :company
  attr_accessible :category, :city, :description, :experiences, :name, :salary, :timetable
end
