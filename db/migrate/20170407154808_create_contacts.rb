class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.string :phone
      t.string :address
      t.string :city
      t.string :pin

      t.timestamps null: false
    end
  end
end
