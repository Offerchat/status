class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.integer :user_id
      t.string :bloodtype
      t.string :allergies
      t.string :surgeries
      t.string :med_conditions
      t.string :injuries
      t.string :reg_med
      t.string :others

      t.timestamps
    end
  end
end
