class OrderBookDecorator < Draper::Decorator
  delegate_all
  
  def book_image
    h.image_tag(object.book.image.thumb, class: 'img-responsive')
  end
end
