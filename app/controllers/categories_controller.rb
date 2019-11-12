class CategoriesController < ApplicationController
  def index
    @parent_categories = Category.where(ancestry: nil)
  end
  

  def show
    @category = Category.find(params[:id])
    category_id = @category.id
    if @category.ancestry == nil
    @items=  Item.joins(:category)
                .where('categories.ancestry = ? OR categories.ancestry LIKE ?', category_id, "#{category_id}/%")
                .where(trade_status: :showing)
                .order(created_at: 'DESC')
    elsif @category.ancestry =~ /^[0-9]+$/
    @items=  Item.joins(:category)
                  .where('categories.ancestry LIKE ?', "%/#{category_id}")
                  .where(trade_status: :showing)
                  .order(created_at: 'DESC')
    else
      @items = Item.where(category_id: @category.id).order("created_at DESC")
    end

  end
  
end
