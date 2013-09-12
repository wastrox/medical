class Admin::Seo::ScopeController < ApplicationController
	layout "admin"
	http_basic_authenticate_with :name => "medicalboss", :password => "BOSSmedical54321"

	skip_before_filter :require_login
	before_filter :find_scope, :only => [:edit, :update]
  before_filter :find_category_list, :only => [:edit, :update]

  def index
  	@scopes = Scope.find(:all)
  end

  def new
  end

  def edit
  end

    def update
      respond_to do |format|
        if @scope.update_attributes(params[:scope])
  		  format.html { redirect_to admin_seo_scope_index_url }
          format.json { render :json => @scope, :status => :created, :location => @scope }
        else
          format.html { render :action => "edit", notes: "Error" }
          format.json { render :json => @scope.errors, :status => :unprocessable_entity }
        end
      end
    end

    protected

    def find_scope
    	@scope = Scope.find(params[:id])
    end

    def find_category_list
      @categories = Category.where(:scope_id => [@scope.id])
    end
end
