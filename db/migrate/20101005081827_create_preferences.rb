class CreatePreferences < ActiveRecord::Migration
  def self.up
    create_table :preferences do |t|
      t.integer :user_id
      t.boolean :twenty_four_hour_format, :default => false
      t.boolean :day_before_month, :default => false
      t.integer :week_start, :default => 0
      t.string :time_zone, :default => "UTC" 

      t.timestamps
    end
    User.all.each {|u| Preference.create(:user_id => u.id)}
  end

  def self.down
    drop_table :preferences
  end
end
