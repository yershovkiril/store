class OrderBooksController < ApplicationController
  def destroy
    book = OrderBook.find(params[:id])
    book.destroy
    redirect_to cart_path
  end
end
