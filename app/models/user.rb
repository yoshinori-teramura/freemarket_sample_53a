class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
                        #omniauth_providers: にてfacebook googleのprovider情報の取得
  
  has_many :items
  has_one  :adress
  has_one  :credit
  has_many  :sns_credentials
  #accepts_nested_attributes_for モデル同士が関連づけされているときにネストさせることで一度にまとめてレコードの更新ができる。
  accepts_nested_attributes_for :adress
  accepts_nested_attributes_for :credit
  accepts_nested_attributes_for :sns_credentials

  enum address_prefecture: {
    選択してください:0,北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,沖縄県:47
    }
  
  protected
  def self.without_sns_data(auth)
    # 値が取得されていない。つまりomniauthでの新規登録の場合
    user = User.where(email: auth.info.email).first
    # Userテーブルのメールアドレスと取得してきた値が同じメールアドレスであれば、userに代入　：メールアドレスで登録があるかの確認
      if user.present?
        # Userテーブルから値が取得できているか？
        sns = SnsCredential.create(
          uid: auth.uid,
          provider: auth.provider,
          user_id: user.id
        )
      else
        user = User.new(
          nickname: auth.info.name,
          email: auth.info.email
        )
        # 新規userインスタンスにnicknameとemailを保存
        sns = SnsCredential.new(
          uid: auth.uid,
          provider: auth.provider
        )
        # 新規sns_credentialインスタンスにuidとproviderを保存
      end
      return { user: user ,sns: sns}
    end

   def self.with_sns_data(auth, snscredential)
    user = User.where(id: snscredential.user_id).first
    unless user.present?
      user = User.new(
        nickname: auth.info.name,
        email: auth.info.email,
      )
    end
    return {user: user}
   end

   def self.find_oauth(auth)
    # request.envにてHTTPリクエストの値を取得し振り分け
    uid = auth.uid
    # =>"103727882963069126588"
    provider = auth.provider
    # =>"google_oauth2"
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    # 取得してきた値と同じものがsns_credentialテーブルに保存されていれば、値を取得してsns_credentialに代入
    if snscredential.present?
      # sns_credentialテーブルから値が取得できているか？
      user = with_sns_data(auth, snscredential)[:user]
      sns = snscredential
    else
      user = without_sns_data(auth)[:user]
      sns = without_sns_data(auth)[:sns]
    end
    return { user: user ,sns: sns}
  end

end
