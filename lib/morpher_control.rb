#encoding: utf-8
require File.dirname(__FILE__) + '/../config/environment'

class MorpherControl

	# ----------------------------------- перебираем весь hash, все value этого хеша конвертируем в string -------------------------------------
	def convert_morpher_to_str(data)
		hash = data
		convert_case_to_str = {}
		hash.each do |k, v|
			if v.is_a?(Hash)
				hash_tmp = {}
				v.each do |k_ins, v_ins|
					 hash_tmp.update({ k_ins.to_sym => v_ins.to_s })
					 convert_case_to_str[k.to_sym] = hash_tmp
				end
			else
				convert_case_to_str[k.to_sym] = v.to_s
			end
		end

		return convert_case_to_str
	end
	# --------------------------------------------------------------------------------------------------------------------------------------------

	# --------------------------------------- Запуск Progress Bar --------------------------------------------------------------------------------
	def print_and_flush(str)
	    print str
	    $stdout.flush
	end

	def init_progress_bar
		progressbar = ProgressBar.create()		
	end

	def get_progress_bar(element)
		object = element
		element_count = object.count.to_f
		step = 100.0/element_count
	end
	# --------------------------------------------------------------------------------------------------------------------------------------------

	def push(str, id)
	    s = str
		morpher_case_pattern = {:И => "", :Р=>"", :Д=>"", :В=>"", :Т=>"", :П=>"", :П_о=>"", :род=>"", :множественное=>{:И=>"", :Р=>"", :Д=>"", :В=>"", :Т=>"", :П=>"", :П_о=>""}, :где=>"", :куда=>"", :откуда=>""}

		if id
			morpher = Morpher.find(id.to_i)
		else
			morpher = Morpher.new
		end

		begin
			parser = MorpherParser.new(s)
			hash_morpher = parser.puts_data
			convert_case = convert_morpher_to_str(hash_morpher)
			convert_case[:И] = s #добавление Именительного падежа
			morpher.case = convert_case
		rescue Exception => e
			puts "Exception MorpherParser: \n #{e} \n Будет сохранен пустой шаблон."
			morpher_case_pattern[:И] = s
			morpher.case = morpher_case_pattern
		end		
		
		if morpher.save 
			#puts "#{y morpher.case}"
			return morpher.id
		else
			puts "\n Слово #{s} не сохранилось в Morpher."
			return false
		end
	end
end
