class RemoteCalendar < ActiveRecord::Base

  belongs_to :user

  def css_class_name
    "remote_calendar_#{self.id}"
  end

end
