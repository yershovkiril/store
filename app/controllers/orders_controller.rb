class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :check_order_in_progress, only: [:edit, :update]
  
  def show
    @order = Order.find(params[:id]).decorate
  end
  
  def edit
  end
  
  def add_book
    book = Book.find(params[:book_id])
    quantity = params[:order][:quantity].to_i
    order_in_progress.add_to_order(book, quantity)
    redirect_to cart_path
  end
  
  def update
    if @order.update(order_params)
      if params.key?(:checkout)
        redirect_to checkout_index_path
      else
        redirect_to cart_path
      end
    else
      flash.now[:danger] = "Invalid coupon code."
      render 'edit'
    end
  end
  
  def empty_cart
    order_in_progress.clear
    redirect_to cart_path
  end
  
  private
  
  def check_order_in_progress
    @order = order_in_progress.decorate
  end
  
  def order_params
    params.require(:order).permit(:code, order_books_attributes: [:id, :quantity])
  end

end
