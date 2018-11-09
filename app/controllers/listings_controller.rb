class ListingsController < ApplicationController
  TAGS = ['tv', 'pool', 'kitchen', 'smoking']

  before_action :set_listing, only: [:edit , :show , :update , :destroy ]
  before_action :authorize_user , only: [:edit , :update , :destroy]
  before_action :moderator_user , only: [:verify]
  def index

    @listings=Listing.all.order("address")

  end
  def new

    @listing = Listing.new


  end

  def create
    @listing = Listing.new(listings_params)
    @listing.user_id=current_user.id

    tags = tags_params.to_h.map do |k,v|
      if v == "1"
        k
      end
    end

    @listing.tags = tags

    if @listing.save
      redirect_to listings_path
    else
      render 'new'
    end
  end
  def show
    @listings=Listing.all

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

  def verify
    @listing=Listing.find(params[:id])

  end

  def user_listings
  end

  def search
    @listings = Listing.text_search(params[:search])


    render 'index'
  end



  private

  def listings_params
    params.require(:listing).permit(:address, :price_per_day, :title_name, :listing_type , :bedrooms , :beds , :bathrooms, {images: []} )
  end

  def tags_params
    params.require('tags').permit(:tv , :kitchen , :pool, :smoking)
  end

  def set_listing
    @listing= Listing.find(params[:id])
  end

  def authorize_user
    if current_user.id != @listing.user_id && current_user.customer?

      redirect_to('listings_path', notice: "Sorry you dont have the authorization")

    end
  end
  def moderator_user
    @listing=Listing.find(params[:id])
    if current_user.superadmin?
      @listing.update(verified: true)
      flash[:notice] = "Successfuly verified"
      redirect_to listings_path

    elsif current_user.moderator?
      @listing.update(verified: true)
      flash[:notice] =  "Successfuly verified"
      redirect_to listings_path

    elsif current_user.customer?
      flash[:notice] = "Sorry you dont have the authorization"
      redirect_to listings_path

    end


  end


end
