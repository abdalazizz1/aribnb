class Listing < ApplicationRecord
  has_many :reservations , dependent: :destroy
  belongs_to :user
  mount_uploaders :images, ImagesUploader

  scope :text_search, -> (text) { where("country ILIKE ? OR title_name ILIKE ? OR city ILIKE ? OR state ILIKE ? OR address ILIKE ?", text, text, text, text, text) }

  # scope :address, (address) -> { where("address ILIKE #{address}") }

  # def self.address(address)
  #   self.where("address ILIKE #{address}")
  # end


end

# Listing.text_search(params[:search])
# Listing.address('Blvd 3') # =>
# Listing.address(params(:search))
