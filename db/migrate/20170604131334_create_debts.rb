class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.references :transaction, index: true, foreign_key: true
      t.integer :debitor_id
      t.integer :creditor_id
      t.float :amount
      t.string :status

      t.timestamps null: false
    end
  end
end
