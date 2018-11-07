
class ReservationsController < ApplicationController
  def show

    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.find(params[:id])



  end


  def new
    @reservation = Reservation.new
  end
  def create


    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    @reservation.hoster_id = @listing.user_id
    @reservation.listing_id = @listing.id

    if @reservation.save
      flash[:notice] = "Reservation created"
      redirect_to listing_reservation_path(@listing , @reservation)
      # redirect_to braintree_new_path(reservation: @reservation)
    else
      flash[:notice]= @reservation.errors.full_messages.join(',')
      render "new"



    end
  end

  # def edit
  #   @reservation = Reservation.find(params[:id])
  # end

  # def update
  #   @reservation = Reservation.find(params[:id])
  #   @reservation.update(reservation_params)
  #   @reservation.user_id = current_user.id
  #   @reservation.hoster_id = @listing.user_id
  #   @reservation.listing_id = @listing.id

  # end





  private

  def reservation_params
    params.require(:reservation).permit(:hoster_id ,:start_date ,:end_date )
  end
end
