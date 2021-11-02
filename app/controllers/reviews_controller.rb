class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_current_book
  
  def new
    @review = @book.reviews.new
  end

  def create
    @review = @book.reviews.new(review_params.merge(user: current_user))
    if @review.save
      redirect_to @book, notice: t('review.flashes.created')
    else
      render :new
    end
  end
  
  private
  
  def find_current_book
    @book = Book.find(params[:book_id])
  end
  
  def review_params
    params.require(:review).permit(:text_review, :rating)
  end
end
