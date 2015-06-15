# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every :day, :at => '02:20am' do
  rake "sitemap:generate"
end

every 5.day, :at => '02:35am' do
  rake "ts:rebuild"
end

# Backup databases medical_production
every :day, :at => '03:00am' do
  command "cd /var/www/medical && backup perform -t medical_production --config-file=/var/www/medical/config/backup/config.rb"
end

# Backup databases Tree 1
#every :day, :at => '01:25pm' do
#  command "cd /var/www/medical && backup perform -t tree --config-file=~/Backup/models/tree.rb"
#end

# Backup databases Tree 2
#every :day, :at => '07:00pm' do
#  command "cd /var/www/medical && backup perform -t tree --config-file=~/Backup/models/tree.rb"
#end

every :day, :at => '03:10am' do
  rake "genxml_vacancies:start"
end

every :day, :at => '08:00am' do	
  rake "publication:start"
end
