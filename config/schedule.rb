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

every :day, :at => '02:35am' do
  rake "ts:rebuild"
end

# Backup databases medical_production
every :day, :at => '03:00am' do
  command "cd /var/www/medical && backup perform -t medical_production --config-file=/var/www/medical/config/backup/config.rb"
end

every :day, :at => '03:10am' do
  rake "genxml_vacancies:start"
end

every :day, :at => '07:30am' do	
  rake "publication:start"
end
