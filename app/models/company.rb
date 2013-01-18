class Company < ActiveRecord::Base
  belongs_to :employer
  attr_accessible :description, :name, :scope, :site
end
