class BraintreeController < ApplicationController
  def new
    @reservation = Reservation.find(params[:id])
    @client_token = Braintree::ClientToken.generate

  end
  def checkout
    @reservation = Reservation.find(params[:id])
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

    result = Braintree::Transaction.sale(
      :amount => @reservation.total_price , #this is currently hardcoded
      :payment_method_nonce => nonce_from_the_client,
      :options => {
        :submit_for_settlement => true
      }
    )
    respond_to do |format|
      if result.success?
        ReservationJob.perform_later(@reservation)
        format.html { redirect_to listing_reservation_path(@reservation.listing, @reservation) , notice: 'Payment was successful.' }
        format.json { render json: @reservation, status: :created, location: @reservation }
      else
        format.html { render action: 'new'}
      format.json { render json: @reservation.errors, status: :unprocessable_entity  , notice: 'Payment failed.'}    end

    end
  end
end
