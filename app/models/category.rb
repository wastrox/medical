class Category < ActiveRecord::Base
  attr_accessible :title

  has_one :vacancies
end
