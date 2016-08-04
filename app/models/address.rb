class Address < ActiveRecord::Base
  belongs_to :country
  validates :first_name, :last_name, :address,
            :zip, :city, :phone, :country, presence: true
  validates_format_of :zip, with: /\d{3}/, message: 'Not less than 3 positive digits'
  validates_format_of :phone, with: /\+(?:[0-9]●?){9,14}[0-9]/, message: 'Invalid format of phone'
end
