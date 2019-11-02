
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
      expect(user.errors[:email]).to include("が入力されていません。")
    end

    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("が入力されていません。")
    end

    # passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    # passwordが5文字以下なら登録できない
    it "is valid with a password that has less than 5 characters " do
      user = build(:user , password: "aaaaa", password_confirmation: "aaaaa")
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上に設定して下さい。")
    end

    # telが数字ではない
    it "is invalid with a tel is string" do
      user = build(:user, tel:"aaaaaa")
      user.valid?
      expect(user.errors[:tel]).to include("は数値で入力してください")
    end

    # telが11文字以外なら登録できない
    it "is invalid with a expect than 11 characters" do
      user = build(:user, tel:"12345678")
      user.valid?
      expect(user.errors[:tel]).to include("は11文字で入力してください")
    end

  end
end
