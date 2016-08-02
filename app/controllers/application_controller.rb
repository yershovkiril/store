class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :order_in_progress
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.user_session_path, alert: exception.message
  end
  
  def get_categories
    @categories = Category.all
  end
  
  def order_in_progress
    @order_in_progress ||= find_order_in_progress
  end
      
  private
  
  def find_order_in_progress
    @order_in_progress = find_by_session_or_user
    if @order_in_progress.nil?
      @order_in_progress = Order.create(user: current_user)
      session[:order_id] = @order_in_progress.id
    elsif current_user && @order_in_progress.user.nil?
      @order_in_progress.user = current_user
      @order_in_progress.save
    end
    @order_in_progress
  end
  
  def find_by_session_or_user
    if session[:order_id]
      Order.find_by(id: session[:order_id])
    elsif current_user
      current_user.orders.in_progress
    end
  end
end
