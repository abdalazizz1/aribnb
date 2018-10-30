class ListingsController < ApplicationController

  def index
    @listings=Listing.all
  end

  def new

    @listing = Listing.new(listings_params)

    if @listing.save

      redirect_to '/'
    end

  end

end
