class AddHours < ActiveRecord::Migration
  def up
  	add_column :schedules,:start_time,:time
  	add_column :schedules,:end_time,:time
  end

  def down
  end
end
