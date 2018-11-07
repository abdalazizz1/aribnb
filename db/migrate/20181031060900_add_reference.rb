class AddReference < ActiveRecord::Migration[5.0]
  def change
    add_reference :listings , :user , index:true
    add_index(:listings, :tags, :using => 'gin')

  end
end
