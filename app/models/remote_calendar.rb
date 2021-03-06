require "open-uri"

class RemoteCalendar < ActiveRecord::Base

  belongs_to :user

  serialize :ical_data

  validates_presence_of :name
  validates_presence_of :url
  validates_presence_of :color

  validate :url_reachable_and_parseable

  def css_class_name
    "remote_calendar_#{self.id}"
  end

  def events(from, to)
    update_ical_data if !self.ical_data or self.ical_data_updated < Time.now.ago(15.minutes)
    events = self.ical_data.collect(&:events).flatten
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

  def update_ical_data
    self.ical_data = RiCal.parse(open(self.url))
    self.ical_data_updated = Time.now
    save(false)
  end

  private

  def url_reachable_and_parseable
    url.sub!("webcal", "http") if url =~ /^webcal:\/\//
    update_ical_data
  rescue Exception => e
    errors.add(:url, "is not reachable or parseable")
  end

end
