class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :doctor_id
      t.string :day
      t.string :clinic_name
      t.string :address
      t.string :contact_num
      t.integer :max_slots

      t.timestamps
    end
  end
end
