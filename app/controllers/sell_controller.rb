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

  private

  def item_params
    params.require(:item).permit(:name, :description, :image, :price)
  end
end
