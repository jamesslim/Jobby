class JobsController < ApplicationController
  before_action :find_job, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
  	@jobs = Job.all.order("created_at DESC")
  end

  def show
  end

  def new
  	@job= current_user.jobs.build
  end

  def create
  	@job = current_user.jobs.build(jobs_params)

  	if @job.save
  	  redirect_to @job
  	else
  	  render "New"
  	end 
  end

  def edit
  end

  def update
  	if @job.update(jobs_params)
  	  redirect_to @job
  	else 
  	  render "Edit"
  	end
  end

  def destroy
  	@job.destroy
  	redirect_to root_path
  end

  private

  def jobs_params
  	params.require(:job).permit(:title, :description, :company, :url)
  end

  def find_job
  	@job = Job.find(params[:id])
  end
end
