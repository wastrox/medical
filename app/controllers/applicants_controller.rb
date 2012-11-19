class ApplicantsController < ApplicationController
  before_filter :init_applicant, :only => [:new, :create]
	before_filter :find_applicant, :only => [:show]

	def new
		@applicant.experiences.build
		@applicant.educations.build
		@applicant.languages.build
		@applicant.pc_skills.build
	end
  
	def create 
		respond_to do |format|
			if @applicant.save
        format.html { redirect_to @applicant }
        format.json { render :json => @applicant, :status => :created, :location => @applicant }
      else
        format.html { render :action => "new" }
        format.json { render :json => @applicant.errors, :status => :unprocessable_entity }
			end
	  end		
	end
	
	def show 
		respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
	end

  protected
	
	def init_applicant
		@applicant = Applicant.new(params[:applicant])
		@applicant ||= Applicant.new
	end

	def find_applicant
		@applicant ||= Applicant.find(params[:id])
	end
end
