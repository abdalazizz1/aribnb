class Reservation < ApplicationRecord
  belongs_to :listing
  belongs_to :user
  validates :start_date, :end_date, :overlap => true


  validate :end_date_is_after_start_date
  validate :start_date_cannot_be_in_the_past
  before_save :calculate_price


  private

  def end_date_is_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "cannot be before the start date")
    end
  end
  def start_date_cannot_be_in_the_past
    if  start_date < Date.today
      errors.add(:start_date, "cannot be in the past")
    end
  end
  def calculate_price
    self.total_price = (end_date-start_date).to_i * (listing.price_per_day)

  end
end
