require File.expand_path('../../../config/environment', __FILE__)

namespace :genxml_vacancies do
    desc ""
    task(:start => :environment) do

    	f = File.open(Rails.root.join('public', 'vacancies.xml'), 'w')

		#@vacancies = Vacancy.where(:state => ["published", "hot"])
		vacancies = Vacancy.find(:all, :conditions => { :state => ["published", "hot"] })

		builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|

		  xml.jobs('hide_contacts' => '1') {
		    vacancies.each do |vacancy|
		      xml.job('id' => vacancy.id) {
		        xml.link_   "http://medical.netbee.ua/vacancy/#{Russian.translit(vacancy.category.scope.title).parameterize}/#{Russian.translit(vacancy.category.name).parameterize}/#{vacancy.to_param}"
		        xml.name_   vacancy.name
		        xml.region_     vacancy.city
		        xml.salary_     vacancy.salary
		        xml.company_     vacancy.company.name
		        xml.companyinfo_     vacancy.company.description
		        xml.description_     vacancy.description
		        xml.contacts_     "#{vacancy.company.company_contacts.first.name}: #{vacancy.company.company_contacts.first.phone}, email: #{vacancy.company.employer.email}"
		        xml.expire_     vacancy.created_at.localtime.next_month.to_formatted_s(:db)
		      }
		    end
		  }
		end
		f.puts builder.to_xml
		f.close

	end # => close task
end  # => close namespace