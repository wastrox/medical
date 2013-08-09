class Admin::TasksController < ApplicationController
  layout "admin"
  http_basic_authenticate_with :name => "medicalboss", :password => "BOSSmedical54321"

  skip_before_filter :require_login
  
  def index
    @incomplete_tasks = Task.where(:complete => false)
    @complete_tasks = Task.where(:complete => true)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create!(params[:task])
    respond_to do |format|
      format.html { redirect_to admin_tasks_url }
      format.js
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    @task.update_attributes!(params[:task])
    respond_to do |format|
      format.html { redirect_to admin_tasks_url }
      format.js
    end
  end

  def destroy
    @task = Task.destroy(params[:id])
    respond_to do |format|
      format.html { redirect_to admin_tasks_url }
      format.js
    end
  end
end
