class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.datetime :from
      t.datetime :to
      t.string :title
      t.string :place
      t.text :description
      t.boolean :all_day
      t.references :calendar

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
