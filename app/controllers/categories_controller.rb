class CategoriesController < ApplicationController
  def index
    @parents = Category.all.order("id ASC").limit(5)

  end

  def show
  end
end
