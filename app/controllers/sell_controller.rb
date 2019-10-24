class SellController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.new
  end

  def create

    Item.transaction do
      item = Item.new(
        name: item_params[:name],
        description: item_params[:description],
        image: item_params[:image],
        price: item_params[:price],
        category_id: item_params[:category_id].to_i,
        shipping_charge: item_params[:shipping_charge].to_i,
        delivery_region: item_params[:delivery_region].to_i,
        delivery_days: item_params[:delivery_days].to_i,
        delivery_type: item_params[:delivery_type].to_i,
        item_status: item_params[:item_status].to_i,
        user_id: current_user.id,
        trade_status: Item.trade_statuses[:showing])

      brand_name = item_params[:brand_id][:name]
      if brand_name.present?
        brand = Brand.find_or_initialize_by(name: brand_name)
        brand.save unless brand.id?
        item.brand_id = brand.id
      end

      item.save!
    end

    # TODO:出品完了ページへ遷移
    redirect_to :root, notice: 'Item was successfully created.'

    rescue => e
      puts e
      redirect_to :root, notice: 'Item was successfully created.'
  end

  def edit
    @item = Item.find(params[:id])
  end

  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find("#{params[:category_id]}").children
  end

  def get_delivery_types
    shipping_charge_id = params[:shipping_charge_id].to_i
    @delivery_types = Item.delivery_types_by_shipping_charge(shipping_charge_id)
  end

  private

  def item_params
    params.require(:item)
          .permit(:name,
                  :description,
                  :image,
                  :price,
                  :category_id,
                  :shipping_charge,
                  :delivery_region,
                  :delivery_days,
                  :delivery_type,
                  :item_status,
                  brand_id: [:name])
  end

end
