class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.date :start_date
      t.date :end_date
      t.integer :hoster_id
    end
    add_reference :reservations , :user , index: true
    add_reference :reservations , :listing , index: true

  end

end
