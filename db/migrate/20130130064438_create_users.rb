class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.date :birthdate
      t.string :med_history
      t.string :contact_number
      t.string :provider
      t.string :uid
      t.string :name
      t.string :lastname
      t.string :firstname
      t.string :sex
      t.string :email
      t.string :address
      t.string :image
      t.string :oauth_token
      t.datetime :oauth_expires_at

      t.timestamps
    end
  end
end
