class AddRecurrenceParamsToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :recurrence_frequency, :string
    add_column :events, :recurrence_until, :date
    add_column :events, :recurrence_interval, :integer
  end

  def self.down
    remove_column :events, :recurrence_frequency
    remove_column :events, :recurrence_until
    remove_column :events, :recurrence_interval
  end
end
