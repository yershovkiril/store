class CreditCard < ActiveRecord::Base
  validates :number, :cvv, :exp_month, :exp_year, presence: true, numericality: true
end
