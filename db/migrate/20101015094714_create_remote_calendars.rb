class CreateRemoteCalendars < ActiveRecord::Migration
  def self.up
    create_table :remote_calendars do |t|
      t.string :name
      t.string :url
      t.string :color, :default => "#3366CC"
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :remote_calendars
  end
end
