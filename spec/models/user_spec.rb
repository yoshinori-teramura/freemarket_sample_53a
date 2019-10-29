
require 'rails_helper'
RSpec.describe User, type: :model do
  describe '#create' do
    # 値が存在すれば登録できる
    it "is valid with a all value" do
      user = build(:user)
      expect(user).to be_valid
    end

    # 以下、カラムが空だと登録できない
    it "is invalid without a nickname" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "is invalid without a family_name" do
      user = build(:user, family_name: "")
      user.valid?
      expect(user.errors[:family_name]).to include("を入力してください")
    end

    it "is invalid without a first_name" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください")
    end

    it "is invalid without a family_kana_name" do
      user = build(:user, family_kana_name: "")
      user.valid?
      expect(user.errors[:family_kana_name]).to include("を入力してください")
    end

    it "is invalid without a first_kana_name" do
      user = build(:user, first_kana_name: "")
      user.valid?
      expect(user.errors[:first_kana_name]).to include("を入力してください")
    end

    it "is invalid without a birthday" do
      user = build(:user, birthday: "")
      user.valid?
      expect(user.errors[:birthday]).to include("を入力してください")
    end

    it "is invalid without a tel" do
      user = build(:user, tel: "")
      user.valid?
      expect(user.errors[:tel]).to include("を入力してください")
    end

    it "is invalid without a email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    # passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    # passwordが６文字以上なら登録できる
    it "is valid with a password that has more than 6 characters " do
      user = build(:user , password: "aaaaaa", password_confirmation: "aaaaaa")
      user.valid?
      expect(user).to be_valid
    end
  end
end
