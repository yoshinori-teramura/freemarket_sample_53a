require 'rails_helper'

RSpec.describe Buyer, type: :model do
  before do
    FactoryBot.create(:item)
  end

  describe '#create' do
    it "正常系" do
      buyer = FactoryBot.build(:buyer, user_id:"1", item_id:"1")
      expect(buyer).to be_valid
    end

    it "存在しないユーザ" do
      buyer = FactoryBot.build(:buyer, user_id:"2", item_id:"1")
      buyer.valid?
      expect(buyer.errors[:user]).to include("を入力してください")
    end

    it "存在しない商品" do
      buyer = FactoryBot.build(:buyer, user_id:"1", item_id:"3")
      buyer.valid?
      expect(buyer.errors[:item]).to include("を入力してください")
    end

  end

end
