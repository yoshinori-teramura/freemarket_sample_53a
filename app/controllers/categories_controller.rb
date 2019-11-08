class CategoriesController < ApplicationController
  def index
    @parent_categories = Category.where(ancestry: nil)
  end
  

  def show
    @category = Category.find(params[:id])
    @items = Item.where(category_id: @category.leaves).page(params[:page]).per(8).order("created_at DESC")
  end

end
