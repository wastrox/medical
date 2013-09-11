# encoding: utf-8

require File.expand_path('../../../config/environment', __FILE__)

namespace :publication do
    desc ""
    task(:start => :environment) do
        def sec2dhms(secs) 
    	    time = secs.round 
    	    sec = time % 60 
    	    time /= 60 
    	    mins = time % 60 
    	    time /= 60 
    	    hrs = time % 24 
    	    time /= 24 
    	    days = time 
    	    [days, hrs, mins, sec] 
      	end

      	now = Time.now.utc

   	  	for vacancy in Vacancy.find(:all, :conditions => { :state => ["published", "hot"] })
   	  		p = vacancy.publicated_at.utc
   	  		diff = now - p
   	  		unit = sec2dhms(diff)
   	  		account = vacancy.company.employer
   	  		date = now
    	  		
   	  		if unit[0] == 29
   	  			subject = "У вакансии #{vacancy.name} оканчивается срок публикации на сайте www.medical.netbee.ua"
   	  			Notifier.letter_published_update_tomorrow(account, subject, vacancy, date).deliver
   	  			puts "Emailing #{account.email}"
   	  		elsif unit[0] >= 30
   	  			subject = "У вакансии #{vacancy.name} окончился срок публикации на сайте www.medical.netbee.ua"
   	  			Notifier.letter_published_update_today(account, subject, vacancy, date).deliver if vacancy.defer
   	  		end
   	  	end
    end
end