class Dropmed < ActiveRecord::Migration
  def up
  	remove_column :users,:med_history
  end

  def down
  end
end
