class CreditCardDecorator < Draper::Decorator
  delegate_all

  def last_numbers
    "**** **** **** #{object.number.last(4)}"
  end

  def expiration_date
    "#{object.exp_month}/#{object.exp_year}"
  end
end