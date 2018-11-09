class ReservationMailer < ApplicationMailer
  default from:'airbnb.reservation.com'

  def booking_email(reservation)
    @reservation = reservation

    @host = reservation.listing.user

    # @url  = 'http://example.com/login'
    mail(to: @host.email, subject: 'Reservation Booked')
  end

end
