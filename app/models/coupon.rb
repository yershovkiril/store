class Coupon < ActiveRecord::Base
  has_many :orders
  
  def active?
    Date.current >= starts_at && Date.current <= expires_at
  end
end



