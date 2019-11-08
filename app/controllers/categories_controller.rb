class CategoriesController < ApplicationController
  def index
    @parent_categories = Category.where(ancestry: nil)
  end
  

  def show
  end

end
