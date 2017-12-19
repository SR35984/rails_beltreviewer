class Event < ActiveRecord::Base
  belongs_to :user
  has_many :attends
  has_many :attendees, through: :attends, source: :user


  before_save :setCase

  validates :name, :location, presence: true, length: { minimum: 2 }
  validates :state, presence: true, length: { is: 2 }
  validate :future_dated

  def setCase
    self.location = self.location.titleize
    self.state.upcase!
  end

  def future_dated
    if date.present?
      if date <= Date.today
        errors.add(:date, "must be in the future!")
      end
    else
      errors.add(:date, "is required.")
    end
  end
end
