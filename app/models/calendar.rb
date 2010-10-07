class Calendar < ActiveRecord::Base

  belongs_to :user

  has_many :events

  def css_class_name
    "calendar_#{self.name.underscore.gsub(/\s/, "_")}"
  end

end
