class AddIcalCacheToRemoteCalendar < ActiveRecord::Migration
  def self.up
    add_column :remote_calendars, :ical_data, :text
    add_column :remote_calendars, :ical_data_updated, :datetime
  end

  def self.down
    remove_column :remote_calendars, :ical_data
    remove_column :remote_calendars, :ical_data_updated
  end
end
