class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]

  # GET /items
  # GET /items.json
  def index
    # 商品のRootカテゴリ
    @categories = Category.where(ancestry: nil)
                          .order(created_at: 'DESC')
                          .limit(4)
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @other_items = Item.where('id <> ? AND user_id = ?', @item.id, @item.user_id)
                       .order(created_at: 'DESC')
                       .limit(6)

    @same_category_items = Category.find(@item.category.id)
                                   .items
                                   .order(created_at: 'DESC')
                                   .where('id <> ?', params[:id])
                                   .limit(6)
  end

  # 商品の出品状態変更ページへ遷移
  def myitem
    @item = Item.find(params[:item_id])
    redirect_to :root unless @item.user.id == current_user.id
  end

  # 出品中の商品を公開停止にする
  def suspend_showing_item
    item = Item.find(params[:item_id])
    if item.user.id == current_user.id && item.trade_status_showing?
      item.update_attribute(:trade_status, :suspend)
      redirect_to action: :myitem, item_id: item.id
    else
      redirect_to :root
    end
    rescue => e
      puts e
      redirect_to :root, notice: "Failed to suspend listing item."
  end

  # 公開停止中の商品を出品中にする
  def resume_showing_item
    item = Item.find(params[:item_id])
    if item.user.id == current_user.id && item.trade_status_suspend?
      item.update_attribute(:trade_status, :showing)
      redirect_to action: :myitem, item_id: item.id
    else
      redirect_to :root
    end
    rescue => e
      puts e
      redirect_to :root, notice: "Failed to resume listing item."
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    # mypageへ遷移
    redirect_to mypages_path, notice: "#{@item.name}を削除しました"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :description, :image, :price)
    end
end
