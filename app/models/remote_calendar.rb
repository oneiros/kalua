require "open-uri"

class RemoteCalendar < ActiveRecord::Base

  belongs_to :user

  def css_class_name
    "remote_calendar_#{self.id}"
  end

  def events(from, to)
    calendars = RiCal.parse(open(self.url))
    events = calendars.collect(&:events).flatten
    result = Array.new
    events.each do |event|
      event.occurrences(:overlapping => [from, to]).each do |e|
        all_day = e.dtstart.instance_of?(Date)
        real_start = all_day ? e.start_time : Time.zone.at(e.start_time.to_i)
        real_end = all_day ? e.finish_time - 1 : Time.zone.at(e.finish_time.to_i)
        result << {
          :title => e.summary,
          :allDay => all_day,
          :start => real_start,
          :end => real_end,
          :description => e.description, 
          :editable => false,
          :className => self.css_class_name
        }
      end
    end
    return result
  end

end
