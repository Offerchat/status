class DeleteLike < ActiveRecord::Migration
  def up
  	drop_table :notifications
  	drop_table :likes
  end

  def down
  end
end
