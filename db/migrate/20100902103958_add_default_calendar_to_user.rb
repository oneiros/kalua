class AddDefaultCalendarToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :calendar_id, :integer
  end

  def self.down
    remove_column :users, :calendar_id
  end
end
