class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :group_id
      t.integer :debitor_id
      t.integer :creditor_id
      t.float :amount
      t.string :status

      t.timestamps null: false
    end
  end
end
