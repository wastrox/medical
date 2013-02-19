class Vacancy < ActiveRecord::Base
  belongs_to :company
  belongs_to :company_contact
  attr_accessible :category, :city, :description, :experiences, :name, :salary, :timetable, :timetable_other, :company_contact_id

	define_index do
		indexes name 
		indexes city
		#has city
		set_property :delta => :delayed
	end
end
