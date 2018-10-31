class CreateTags < ActiveRecord::Migration[5.0]
  def change
    add_column :listings , :tags , :text , array: true , :using => 'gin'


  end
end
