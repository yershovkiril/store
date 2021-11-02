class BookDecorator < Draper::Decorator
  delegate_all
  
  def reviews
    object.reviews.where(approved: true)
  end
  
  def author_name
    object.author.map { |a| AuthorDecorator.new(a).full_name }.join(', ')
  end
end
