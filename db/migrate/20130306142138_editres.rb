class Editres < ActiveRecord::Migration
  def up
  	add_column :reservations,:restype,:string
  end

  def down
  end
end
