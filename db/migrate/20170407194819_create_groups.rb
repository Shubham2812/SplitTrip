class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :no_of_members

      t.timestamps null: false
    end
  end
end
