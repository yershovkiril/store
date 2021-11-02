class Shipment < ActiveRecord::Base
  validates :name, :price, presence: true
end
