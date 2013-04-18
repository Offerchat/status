class Change < ActiveRecord::Migration
  def up
  	remove_column :users,:type
  	add_column :users,:usertype,:string
  end

  def down
  end
end
