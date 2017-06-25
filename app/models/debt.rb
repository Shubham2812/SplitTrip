class Debt < ActiveRecord::Base
  belongs_to :xyz, foreign_key: "transaction_id", class_name: "Transaction"
end
