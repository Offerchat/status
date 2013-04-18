class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.integer :user_id
      t.string :ed_attainment
      t.string :specialization
      t.string :office_address
      t.string :office_contact

      t.timestamps
    end
  end
end
