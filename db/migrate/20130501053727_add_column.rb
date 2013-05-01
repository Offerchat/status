class AddColumn < ActiveRecord::Migration
  def up
  	add_column :announcements, :auto, :boolean, :default => false, :null => true
  end

  def down
  end
end
