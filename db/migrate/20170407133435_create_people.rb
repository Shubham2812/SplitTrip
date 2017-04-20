class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :user_id
      t.string :username
      t.string :name
      t.string :gender
      t.date :dob

      t.timestamps null: false
    end
  end
end
