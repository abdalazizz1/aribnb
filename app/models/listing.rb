class Listing < ApplicationRecord
  has_many :reservations , dependent: :destroy
  belongs_to :user
  mount_uploaders :images, ImagesUploader


end
