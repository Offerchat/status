class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :doctor_id
      t.integer :patient_id
      t.boolean :like

      t.timestamps
    end
  end
end
