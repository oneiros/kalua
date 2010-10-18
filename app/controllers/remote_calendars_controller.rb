class RemoteCalendarsController < ApplicationController

  before_filter :authenticate_user!

  def new
    @remote_calendar = RemoteCalendar.new
  end

  def create
    @remote_calendar = current_user.remote_calendars.new(params[:remote_calendar])
    if @remote_calendar.save
      redirect_to calendars_path
    else
      render :action => "new"
    end
  end

  def edit
    @remote_calendar = current_user.remote_calendars.find(params[:id])
  end

  def update
    @remote_calendar = current_user.remote_calendars.find(params[:id])
    if @remote_calendar.update_attributes(params[:remote_calendar])
      redirect_to calendars_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @remote_calendar = current_user.remote_calendars.find(params[:id])
    @remote_calendar.destroy
    redirect_to calendars_path
  end

end
