class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :address
      t.integer :price_per_day
      t.string :title_name

      t.timestamps
    end
  end
end
