#encoding: UTF-8
require File.expand_path('../../../config/environment', __FILE__)

namespace :genxml_vacancies do
    desc ""
    task(:start => :environment) do

		vacancies = Vacancy.find(:all, :conditions => { :state => ["published", "hot"] })

		# Generate xml file for http://jooble.com.ua/
		builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
		  xml.jobs('hide_contacts' => '1') {
		    vacancies.each do |vacancy|
		      xml.job('id' => vacancy.id) {
		        xml.link_   "http://medical.netbee.ua/vacancy/#{Russian.translit(vacancy.category.scope.title).parameterize}/#{Russian.translit(vacancy.category.name).parameterize}/#{vacancy.to_param}"
		        xml.name_   vacancy.name
		        xml.region_     vacancy.city
		        xml.salary_     "#{vacancy.salary} грн"
		        xml.company_     vacancy.company.name
		        xml.companyinfo_     vacancy.company.description
		        xml.description_     vacancy.description
		        xml.contacts_     "#{vacancy.company.company_contacts.first.name}: #{vacancy.company.company_contacts.first.phone}, email: #{vacancy.company.employer.email}"
		        xml.expire_     vacancy.publicated_at.next_month.strftime("%d.%m.%Y")
		      }
		    end
		  }
		end

		# Create xml file for http://jooble.com.ua/
		f = File.open(Rails.root.join('public', 'vacancies.xml'), 'w')
		f.puts builder.to_xml
		f.close

		# Generate xml file for http://ua.trovit.com/
		trovitBuilder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
		  xml.trovit {
		    vacancies.each do |vacancy|
		      xml.ad('id' => vacancy.id) {
		        xml.id(){          xml.cdata "#{vacancy.id}" }
		        xml.title(){       xml.cdata  vacancy.name}
		        xml.url(){         xml.cdata "http://medical.netbee.ua/vacancy/#{Russian.translit(vacancy.category.scope.title).parameterize}/#{Russian.translit(vacancy.category.name).parameterize}/#{vacancy.to_param}"}
		        xml.content(){     xml.cdata  vacancy.description }
		        xml.company() {    xml.cdata vacancy.company.name }
		        xml.experience() { xml.cdata vacancy.experiences }
		        xml.category(){    xml.cdata vacancy.category.name }
		        xml.salary(){ 	   xml.cdata "#{vacancy.salary} грн" }
		        xml.city(){ 	   xml.cdata vacancy.city }
		        xml.date(){ 	   xml.cdata vacancy.publicated_at.strftime("%d.%m.%Y") }
		        xml.expiration_date(){ xml.cdata vacancy.publicated_at.next_month.strftime("%d.%m.%Y") }
		      }
		    end
		  }
		end

		# Create xml file for http://ua.trovit.com/
		trovitFile = File.open(Rails.root.join('public', 'vacanciesForTrovit.xml'), 'w')
		trovitFile.puts trovitBuilder.to_xml
		trovitFile.close

		#----------------------------------------------------------------------------------------------------------------------------------
		# Generate xml file for Rabotalux
		# trovitBuilder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
		#   xml.source('creationTime' => Time.now, 'host' => 'http://medical.netbee.ua/') {
		#     vacancies.each do |vacancy|
		#       xml.vacancy('id' => vacancy.id) {
		#         xml.title_   		vacancy.name
		#         xml.company_    	vacancy.company.name
		#         xml.site_   		"http://#{vacancy.company.site}" 
		#         xml.description_    vacancy.description
		#         xml.source_   		"http://medical.netbee.ua/vacancy/#{Russian.translit(vacancy.category.scope.title).parameterize}/#{Russian.translit(vacancy.category.name).parameterize}/#{vacancy.to_param}"
		#         xml.category_    	vacancy.category.name
		#         xml.date_			vacancy.publicated_at.strftime("%d.%m.%Y")
		#         xml.salary{     		xml.amount_ vacancy.salary 
		#         						xml.currency_ "UAH" }
		#         xml.location_     	vacancy.city
		#       }
		#     end
		#   }
		# end

		# # Create xml file for Rabotalux
		# rabotaluxFile = File.open(Rails.root.join('public', 'vacanciesForRabotalux.xml'), 'w')
		# rabotaluxFile.puts trovitBuilder.to_xml
		# rabotaluxFile.close
		#--------------------------------------------------------------------------------------------------------------------------------

	end # => close task
end  # => close namespace
