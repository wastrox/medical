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

      # def progress_init
      #   progress = ProgressBar.create( :format => '%a %bᗧ%i %p%% %t',
      #                   :progress_mark  => ' ',
      #                   :remainder_mark => '･')
      # end

      msg_arr=[]
      vacancies_notifier = []
      time =[]
      msg = {}
    	date = Time.now.utc
      vacancies = Vacancy.where(state: ["published", "hot"])

      # progress = progress_init
      # step = 100.0/vacancies.count.to_f

 	  	vacancies.each do |vacancy|
        begin
          p = vacancy.publicated_at.utc
          diff = date - p
          unit = sec2dhms(diff)
          account = vacancy.company.employer

          if unit[0] == 29
            subject = "У вакансии #{vacancy.name} оканчивается срок публикации на сайте www.medical.netbee.ua"
            Notifier.letter_published_update_tomorrow(account, subject, vacancy, date).deliver
            puts "Sleep if == 29 | #{vacancy.name}-#{vacancy.id} | unit: #{unit} vacancy.publicated_at: #{p} | state now: #{vacancy.state}"
            sleep(0.04.minutes)

            vacancies_notifier << vacancy
            time << {day: "29 дней", id: vacancy.id}

          elsif unit[0] >= 30
            subject = "У вакансии #{vacancy.name} окончился срок публикации на сайте www.medical.netbee.ua"
            Notifier.letter_published_update_today(account, subject, vacancy, date).deliver if vacancy.defer
            state_old = vacancy.state
            
            puts "Sleep elsif >= 30 | #{vacancy.name}-#{vacancy.id} | unit: #{unit} vacancy.publicated_at: #{p} | state now: #{vacancy.state} state old #{state_old}"
            sleep(0.04.minutes)

            vacancies_notifier << vacancy
            time << {day: "30 дней", id: vacancy.id}
          end  
        rescue Exception => e
          msg_arr << msg[:error] = e
        end
        # progress.progress += step
 	  	end
      
      Notifier.letter_nicholauskas_debug(vacancies_notifier, time, msg_arr).deliver

      # puts "vacancies_notifier: #{vacancies_notifier.count}"
  end
end