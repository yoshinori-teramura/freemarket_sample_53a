require 'rails_helper'

# RSpec.describe Item, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

RSpec.describe Item, type: :model do
  
  before do
    @user = FactoryBot.create(:user)
  end

  describe '#create' do
    # 値が存在すれば登録できる
    it "is valid with a all value" do
      user = @user
      category = Category.new(id:"1")
      item = build(:item, user_id:"1",category_id:"1")
      expect(item).to be_valid
    end

    # 以下、カラムが空だと登録しない
    it "is invalid without a name" do
      user = @user
      item = build(:item, name:"", user_id:"1")
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "is invalid without a image" do
      user = @user
      item = build(:item, image:"", user_id:"1")
      item.valid?
      expect(item.errors[:image]).to include("を入力してください")
    end

    it "is invalid without a description" do
      user = @user
      item = build(:item, description:"", user_id:"1")
      item.valid?
      expect(item.errors[:description]).to include("を入力してください")
    end

    it "is invalid without a price" do
      user = @user
      item = build(:item, price:"", user_id:"1")
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

    it "is invalid without a  item_status" do
      user = @user
      item = build(:item, item_status:"", user_id:"1")
      item.valid?
      expect(item.errors[:item_status]).to include("を入力してください")
    end

    it "is invalid without a trade_status" do
      user = @user
      item = build(:item, trade_status:"", user_id:"1")
      item.valid?
      expect(item.errors[:trade_status]).to include("を入力してください")
    end

    it "is invalid without a delivery_region" do
      user = @user
      item = build(:item, delivery_region:"", user_id:"1")
      item.valid?
      expect(item.errors[:delivery_region]).to include("を入力してください")
    end

    it "is invalid without a shipping_charge" do
      user = @user
      item = build(:item, shipping_charge:"", user_id:"1")
      item.valid?
      expect(item.errors[:shipping_charge]).to include("を入力してください")
    end

    it " is invalid without a delivery_type" do
      user = @user
      item = build(:item,delivery_type:"", user_id: "1")
      item.valid?
      expect(item.errors[:delivery_type]).to include("を入力してください")
    end

    it " is invalid without a delivery_days" do
      user= @user
      item= build(:item, delivery_days:"", user_id: "1")
      item.valid?
      expect(item.errors[:delivery_days]).to include("を入力してください")
    end

    it " is invalide without a category_id" do
      user= @user 
      item=build(:item, category_id:"", user_id:"1")
      item.valid?
      expect(item.errors[:category_id]).to include("を入力してください")
    end

    # nameが40文字以上だと登録できない
    it " is invalid with a name that has more that 40 characters" do
      user = @user
      item = build(:item, name:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", user_id:"1")
      item.valid?
      expect(item.errors[:name]).to include("は40文字以内で入力してください")
    end

    # priceが数字ではない
    it "is invalid with a price is string" do
      user = @user 
      item = build(:item, price:"aaaaaa", user_id:"1")
      item.valid?
      expect(item.errors[:price]).to include("は数値で入力してください")
    end

    # priceが11文字以外なら登録できない
    it "is invalid with a price is expect than 11 characters" do
      user = @user
      item = build(:item, price:"200", user_id:"1")
      item.valid?
      expect(item.errors[:price]).to include("は300以上の値にしてください")
    end

    # priceが11文字以外なら登録できない
    it "is invalid with a price is expect than 11 characters" do
      user = @user
      item = build(:item, price:"100000000", user_id:"1")
      item.valid?
      expect(item.errors[:price]).to include("は9999999以下の値にしてください")
    end
    
  end
end

