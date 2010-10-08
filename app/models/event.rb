class Event < ActiveRecord::Base

  RECURRENCE_FREQUENCIES = ["daily", "weekly", "monthly", "yearly"]

  belongs_to :calendar

  before_save :set_to_time

  scope :candidates, lambda {|from, to|
    {:conditions => ["(events.recurrence_frequency IS NULL AND events.`from` < ? AND events.`to` > ?) OR (events.recurrence_frequency IS NOT NULL AND (events.recurrence_until IS NULL or events.recurrence_until > ?))", to, from, from]}
  }

  validates_inclusion_of :recurrence_frequency, :in => RECURRENCE_FREQUENCIES, :allow_nil => true

  def self.all_from_user_between(user, from, to)
    result = Array.new
    candidates = self.candidates(from, to)
    candidates.each do |event|
      if event.recurrence_frequency
        while event.from < to
          result << event.to_hash if event.from < to and event.to > from and !(event.recurrence_until and event.from.to_date > event.recurrence_until)
          case event.recurrence_frequency
            when "daily"
              event.from = event.from.since(1.day)
              event.to = event.to.since(1.day)
            when "weekly"
              event.from = event.from.since(7.days)
              event.to = event.to.since(7.days)
            when "monthly"
              event.from = event.from.since(1.month)
              event.to = event.to.since(1.month)
            when "yearly"
              event.from = event.from.since(1.year)
              event.to = event.to.since(1.year)
          end
        end

      else
        result << event.to_hash
      end
    end
    result
  end

  def to_hash
    {
      :id => self.id,
      :title => self.title,
      :allDay => self.all_day?,
      :start => self.from,
      :end => self.to,
      :description => self.description,
      :editable => true,
      :className => self.calendar.css_class_name,
      :url => "/events/#{self.id}/edit"
    }
  end

  private

  def set_to_time
    self.to = self.from.since(1.hour) unless self.to
  end

end
