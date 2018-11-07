require 'faker'

user = {}
user['password'] = 'asdf'

ActiveRecord::Base.transaction do
  20.times do
    user['first_name'] = Faker::Name.first_name
    user['last_name'] = Faker::Name.last_name
    user['email'] = Faker::Internet.email

    User.create(user)
  end
end

# Seed Listings
listing = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  40.times do
    listing['title_name'] = Faker::App.name
    listing['listing_type'] = ["House", "Entire Floor", "Condominium", "Villa", "Townhouse", "Castle", "Treehouse", "Igloo", "Yurt", "Cave", "Chalet", "Hut", "Tent", "Other"].sample
    listing['tags'] = ["Kitchen", "TV", "Pool", "Gym", "Washer", "Iron", "Private Bathroom"].sample(rand(7))


    listing['user_id'] = uids.sample
    listing['address'] = Faker::Address.street_address

    listing['price_per_day'] = rand(40..500)
    listing['bedrooms'] = rand(1..10)
    listing['bathrooms'] = rand(1..10)
    listing['beds'] = rand(1..15)
    listing['country'] = Faker::Address.country
    listing['state'] = Faker::Address.state
    listing['city'] = Faker::Address.city




    Listing.create(listing)
  end
end
