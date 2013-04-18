class Addweeed < ActiveRecord::Migration
  def up
  	add_column :reservations,:schedule_id,:integer
  	add_column :reservations,:user_id,:integer
  end

  def down
  end
end
