class AddColumnToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :confirmed_by, :string
  end
end
