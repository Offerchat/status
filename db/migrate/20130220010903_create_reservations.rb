class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.date :reserved_date
      t.time :time_start
      t.time :time_end
      t.integer :doctor_id
      t.integer :patient_id
      t.string :type

      t.timestamps
    end
  end
end
