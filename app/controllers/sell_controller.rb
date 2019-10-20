class SellController < ApplicationController

  def index
    @item = Item.new
    @categories = []
    @categories << ["---", 0]
    #データベースから、Rootカテゴリーのみ抽出し、配列化
    Category.where(ancestry: nil).each do |root|
      @categories << [root.name, root.id]
    end
  end

  def create
    @item = Item.new(item_params)
    @item.save
    # TODO:出品完了ページへ遷移
    redirect_to :root, notice: 'Item was successfully created.'
  end

  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find("#{params[:category_id]}").children
  end

  def get_category_grandchildren
    # 選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:category_id]}").children
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :image, :price)
  end

  def get_categories(grandchild_id)
    @cetegory_child_id = Category.find(grandchild_id).parent_id
    @cetegory_id = Category.find(@cetegory_child_id).parent_id
  end
end
