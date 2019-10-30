require 'rails_helper'

# RSpec.describe Address, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
RSpec.describe Address, type: :model do
  
  before do
    @user = FactoryBot.create(:user)
  end

  describe '#create' do
    # 値が存在すれば登録できる
    it "is valid with a all value" do
      user = @user
      address = build(:address, user_id:"1")
      expect(address).to be_valid

    end

    # 以下、カラムが空だと登録しない
    it "is invalid without a delivery_family_name" do
      user = @user
      address = build(:address, delivery_family_name:"", user_id:"1")
      address.valid?
      expect(address.errors[:delivery_family_name]).to include("を入力してください")
    end

    it "is invalid without a delivery_first_name" do
      user = @user
      address = build(:address, delivery_first_name:"", user_id:"1")
      address.valid?
      expect(address.errors[:delivery_first_name]).to include("を入力してください")
    end

    it "is invalid without a delivery_family_kana_name" do
      user = @user
      address= build(:address, delivery_family_kana_name:"", user_id:"1")
      address.valid?
      expect(address.errors[:delivery_family_kana_name]).to include("を入力してください")
    end

    it "is invalid without a delivery_first_kana_name" do
      user = @user
      address = build(:address, delivery_first_kana_name:"", user_id:"1")
      address.valid?
      expect(address.errors[:delivery_first_kana_name]).to include("を入力してください")
    end
    
    it "is invalid without a postal_code" do
      user= @user
      address=build(:address, postal_code:"", user_id:"1")
      address.valid?
      expect(address.errors[:postal_code]).to include("を入力してください")
    end

    it " is invalid without a city " do
      user= @user
      address= build(:address, city:"", user_id:"1")
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end

    it " is invalid without a block " do
      user= @user
      address= build(:address, block:"", user_id:"1")
      address.valid?
      expect(address.errors[:block]).to include("を入力してください")
    end

    it " is invalid without a prefecture_id " do
      user= @user
      address= build(:address, prefecture_id:"", user_id:"1")
      address.valid?
      expect(address.errors[:prefecture_id]).to include("を入力してください")
    end
  end
end
