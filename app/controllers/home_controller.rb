class HomeController < ApplicationController
  def index
    @best_books = Book.best_books.limit(5).decorate
  end
end
