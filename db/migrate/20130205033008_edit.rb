class Edit < ActiveRecord::Migration
  def up
  	remove_column :users,:male
  	add_column :users,:sex,:string
  end

  def down
  end
end
