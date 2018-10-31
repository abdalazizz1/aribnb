class AddColumnsListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings , :listing_type , :string
    add_column :listings , :bedrooms , :integer
    add_column :listings , :beds , :integer
    add_column :listings , :bathrooms , :integer



  end
end
