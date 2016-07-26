class CategoriesController < ApplicationController
  before_action :get_categories
  
  def show
    @category = Category.find(params[:id])
    @books = @category.books.page(params[:page])
  end
end
