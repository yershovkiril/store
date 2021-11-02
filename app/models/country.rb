class Country < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  has_many :addresses
end
