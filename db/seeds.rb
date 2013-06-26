# emcoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

["Аптека", "Лечебно-профилактическое учреждение", "Фармацевтическое производство", "Компания-дистрибьютор", "Оптовая компания", "Другое"].each do |scope|
  Scope.find_or_create_by_title(scope)
end