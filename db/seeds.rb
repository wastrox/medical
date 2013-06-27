# emcoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

if Scope.all.empty?
	puts "Importing scope title..."
	CSV.foreach(Rails.root.join("scope.csv"), headers: true) do |row|
	  Scope.create! do |scope|
	    scope.id = row[0]
	    scope.title = row[1]
	  end
	end
else
	puts "Scope not nil!"
end

if Category.all.empty?
	puts "Importing category name..."
	CSV.foreach(Rails.root.join("category.csv"), headers: true) do |row|
	  Category.create! do |category|
	  	category.id = row[0]
	    category.name = row[1]
	    category.scope_id = row[2]
	  end
	end
else 
	puts "Category not nil!"
end
