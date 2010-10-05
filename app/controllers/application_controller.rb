class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_time_zone

  private

  def set_time_zone
    Time.zone = current_user.preference.time_zone if current_user
  end

end
