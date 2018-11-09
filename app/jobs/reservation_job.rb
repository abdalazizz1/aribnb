class ReservationJob < ApplicationJob
  queue_as :default

  def perform(reservation)
    ReservationMailer.booking_email(reservation).deliver_later


    # Do something later
  end
end
