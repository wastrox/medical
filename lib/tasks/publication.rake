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

        msg_error =[]
        vacancies_notifier = []
        msg = {}
      	date = Time.now.utc
        vacancies = Vacancy.where(state: ["published", "hot"])

   	  	vacancies.each do |vacancy|
   	  		p = vacancy.publicated_at.utc
   	  		diff = date - p
   	  		unit = sec2dhms(diff)
   	  		account = vacancy.company.employer	
          begin
            if unit[0] == 29
              subject = "У вакансии #{vacancy.name} оканчивается срок публикации на сайте www.medical.netbee.ua"
              Notifier.letter_published_update_tomorrow(account, subject, vacancy, date).deliver
              puts "Sleep if == 29"
              sleep(0.2.minutes)
            elsif unit[0] >= 30
              subject = "У вакансии #{vacancy.name} окончился срок публикации на сайте www.medical.netbee.ua"
              Notifier.letter_published_update_today(account, subject, vacancy, date).deliver if vacancy.defer
              puts "Sleep elsif >= 30"
              sleep(0.2.minutes)
            end  
            vacancies_notifier << vacancy
            Notifier.letter_nicholauskas_debug(vacancies_notifier).deliver
          rescue Exception => e
            msg_error << msg[:error] = e
          end
   	  	end
    end
end