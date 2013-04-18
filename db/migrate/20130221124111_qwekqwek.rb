class Qwekqwek < ActiveRecord::Migration
  def up
  	remove_column :reservations,:time_start
  	remove_column :reservations,:time_end
  	add_column :reservations,:start_time,:datetime
  	add_column :reservations,:end_time,:datetime
  end

  def down
  end
end
