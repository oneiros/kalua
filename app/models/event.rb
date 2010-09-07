class Event < ActiveRecord::Base

  belongs_to :calendar

  before_save :set_to_time

  def self.user_events_json(user)
    result = []
    user.events.each do |event|
      result << {
        :id => event.id,
        :title => event.title,
        :allDay => event.all_day?,
        :start => event.from,
        :end => event.to,
        :description => event.description,
        :editable => true,
        :url => "/events/#{event.id}/edit"
      }
    end
    result.to_json
  end

  private

  def set_to_time
    self.to = self.from.since(1.hour) unless self.to
  end

end
