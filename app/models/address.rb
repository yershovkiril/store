class Address < ActiveRecord::Base
  belongs_to :country
  validates :first_name, :last_name, :address,
            :zip, :city, :phone, :country, presence: true
end
