class CategoriesController < ApplicationController
  def index
    @parent_categories = Category.where(ancestry: nil)
  end
  

  def show
    @category = Category.find(params[:id])
    
    #if @category.id = 1 || 14 || 27
      #@categories = Category.where(ancestry: nil).order(created_at: 'DESC').limit(8)
      #@category_children = @category.children 
      #@category_grandchildren = @category_children.children
      #@items = Item.where(category_id: @category_grandchildren.id).order("created_at DESC")
    #else
      #@items = Item.where(category_id: @category.id).order("created_at DESC")
    #end
    @items = Item.where(category_id: @category.id).order("created_at DESC")
  end
  
end
