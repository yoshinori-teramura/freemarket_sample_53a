class CategoriesController < ApplicationController
  def index
    @parent_categories = Category.where(ancestry: nil)
  end
  

  def show
    @category = Category.find(params[:id])
    @categories = Category.where(ancestry: nil)
                          .order(created_at: 'DESC')
                          .limit(4)
    @items = Item.where(category_id: @category.id).paginate(page: params[:page], per_page: 8).order("created_at DESC")
  end

end
