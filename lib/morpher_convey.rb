#encoding: utf-8
require File.dirname(__FILE__) + '/../config/environment'

class MorpherConvey

	def print_and_flush(str)
	  print str
	  $stdout.flush
	end

	def progress_init
		progress = ProgressBar.create( :format => '%a %bᗧ%i %p%% %t',
                    :progress_mark  => ' ',
                    :remainder_mark => '･')
	end

	def case_morphology_convey(object)
  		str = object.title
  		morpher = MorpherControl.new
	  	result = morpher.push(str, object.morpher_id)
	  	result ? object.morpher_id = result : false
	  	object.save
  	end

	def convey_start
		progress = progress_init

		object = Scope.all

		step = 100.0/object.count.to_f

		object.each do |o|
			begin
				case_morphology_convey(o)
				progress.progress += step
			rescue Exception => e
				puts "#{e}"
			end
		end
	end
end