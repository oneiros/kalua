class AddColorToCalendar < ActiveRecord::Migration
  def self.up
    add_column :calendars, :color, :string, :default => "#3366CC"
  end

  def self.down
    remove_column :calendars, :color
  end
end
