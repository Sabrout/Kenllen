class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.integer :phone
      t.string :email
      t.string :address
      t.string :image
      t.integer :reports , default: 0 
    end
  end
end
