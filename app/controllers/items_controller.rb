class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    # @items = Item.all
    @items = Item.limit(10).order(" created_at DESC ")
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

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    #respond_to do |format|
    #  format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
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
