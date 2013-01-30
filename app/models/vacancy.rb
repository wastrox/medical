class Vacancy < ActiveRecord::Base
  belongs_to :company
  belongs_to :company_contact
  attr_accessible :category, :city, :description, :experiences, :name, :salary, :timetable, :timetable_other, :company_contact_id
end
