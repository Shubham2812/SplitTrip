class AddColumnToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :name, :string
  end
end
