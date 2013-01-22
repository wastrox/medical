class StartpageController < ApplicationController
 layout "startpage"
 skip_before_filter :require_login, :only => [:index]
	def index
	end
	
	def testIndex
	end

	def resume
	end
end
