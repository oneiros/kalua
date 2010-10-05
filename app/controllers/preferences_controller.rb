class PreferencesController < ApplicationController

  before_filter :authenticate_user!

  def edit
    @preference = current_user.preference
  end

  def update
    @preference = current_user.preference

    respond_to do |format|
      if @preference.update_attributes(params[:preference])
        flash[:notice] = 'Preferences were successfully updated.'
        format.html { redirect_to(calendars_path) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

end
