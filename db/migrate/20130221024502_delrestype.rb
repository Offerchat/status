class Delrestype < ActiveRecord::Migration
  def up
  	remove_column :reservations,:type
  	add_column :reservations,:restype,:string
  end

  def down
  end
end
