class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :group, index: true, foreign_key: true
      t.time :start_time
      t.time :end_time
      t.string :status

      t.timestamps null: false
    end
  end
end
