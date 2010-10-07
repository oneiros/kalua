class CalendarsController < ApplicationController

  before_filter :authenticate_user!

  def index
    render :layout => "calendar"
  end

  def new
    @calendar = Calendar.new
  end

  def create
    @calendar = current_user.calendars.new(params[:calendar])
    if @calendar.save
      redirect_to calendars_path
    else
      render :action => "new"
    end
  end

  def edit
    @calendar = current_user.calendars.find(params[:id])
  end

  def update
    @calendar = current_user.calendars.find(params[:id])
    if @calendar.update_attributes(params[:calendar])
      redirect_to calendars_path
    else
      render :action => "edit"
    end
  end

  def styles
    @calendars = current_user.calendars
  end

end
