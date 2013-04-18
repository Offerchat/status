class DeletePatient < ActiveRecord::Migration
  def up
  	drop_table :patients
  	remove_column :reservations,:start_time
  	remove_column :reservations,:end_time
  	remove_column :reservations,:doctor_id
  	remove_column :reservations,:patient_id
  	remove_column :reservations,:restype
  end

  def down
  end
end
