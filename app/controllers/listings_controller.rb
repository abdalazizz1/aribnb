class ListingsController < ApplicationController

  def index

    @listings=Listing.all

  end
  def new

    @listing = Listing.new

  end

  def create

    @listing = Listing.new(listings_params)
    @listing.user_id=current_user.id
    if @listing.save
      redirect_to listings_path
    else
      render 'new'
    end
  end
  def show
    @listing=Listing.find(params[:id])

  end

  def edit
    @listing = Listing.find(params[:id])
  end


  def update
    @listing = Listing.find(params[:id])
    @listing.update(listings_params)
    @listing.user_id=current_user.id
    if @listing.save
      redirect_to listings_path
    else
      render 'edit'
    end
  end

  def destroy
    @listing = Listing.find(params[:id]).destroy
    redirect_to listings_path
  end




  private

  def listings_params
    params.require(:listing).permit(:address, :price_per_day, :title_name, :listing_type , :bedrooms , :beds , :bathrooms , :tags )
  end

end
