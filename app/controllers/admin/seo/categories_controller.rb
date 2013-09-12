class Admin::Seo::CategoriesController < ApplicationController
	layout "admin"
	http_basic_authenticate_with :name => "medicalboss", :password => "BOSSmedical54321"

	skip_before_filter :require_login
	before_filter :find_category, :only => [:edit, :update, :find_category_list]
  before_filter :find_category_list, :only => [:edit, :update]

  def index
    @categories = Category.where(:scope_id => params[:scope])
  end

  def new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @category.update_attributes(params[:category])
    format.html { redirect_to edit_admin_seo_scope_path(@category.scope) }
        format.json { render :json => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "edit", notes: "Error" }
        format.json { render :json => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

    protected

    def find_category
    	@category = Category.find(params[:id])
    end

    def find_category_list
      @categories = Category.where(:scope_id => [@category.scope.id])
    end
end
