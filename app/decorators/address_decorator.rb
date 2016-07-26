class AddressDecorator < Draper::Decorator
  delegate_all
  delegate :address
  
  def full_name
    "#{object.first_name} #{object.last_name}"
  end
  
end