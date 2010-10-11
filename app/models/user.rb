class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :confirmable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  belongs_to :calendar # default calendar for this user
  has_one :preference
  has_many :calendars
  has_many :events, :through => :calendars

  after_create :create_default_calendar_and_preferences

  private

  def create_default_calendar_and_preferences
    self.calendar = Calendar.create(:name => "default", :user_id => self.id)
    self.preference = Preference.create(:user_id => self.id)
  end

end
