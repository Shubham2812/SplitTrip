class Transaction < ActiveRecord::Base
  belongs_to :group
  has_many :debts
end
