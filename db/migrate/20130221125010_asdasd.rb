class Asdasd < ActiveRecord::Migration
  def up
  	remove_column :reservations,:start_time
  	remove_column :reservations,:end_time
  	add_column :reservations,:start_time,:time
  	add_column :reservations,:end_time,:time
  end

  def down
  end
end
