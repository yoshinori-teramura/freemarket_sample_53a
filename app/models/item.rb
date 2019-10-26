class Item < ApplicationRecord
  validates :description, presence: true, unless: :image?

  mount_uploader :image, ImageUploader

  belongs_to :user
  belongs_to :category
  belongs_to :brand, optional: true


  validates :name, presence: true, length: {maximum: 40}
  validates :description, presence: true, length: {maximum: 1000}
  validates :item_status, :shipping_charge, :delivery_region,
            :delivery_type, :delivery_days, :trade_status, :image,
            presence: true
  # validates_with ItemPriceValidator

  # 商品の状態
  enum item_status: {
    "---": 0, "新品、未使用": 1, "未使用に近い": 2,
    "目立った傷や汚れなし": 3, "やや傷や汚れあり": 4,
    "傷や汚れあり": 5, "全体的に状態が悪い": 6
  }, _prefix: true

  # 取引の状態
  enum trade_status: {
    showing: 1, # 出品中
    trading: 2, # 取引中
    sold: 3 #売却済み
  }, _prefix: true

  # 配送元の地域
  enum delivery_region: {
    "---":0,"北海道":1,"青森県":2,"岩手県":3,"宮城県":4,"秋田県":5,"山形県":6,"福島県":7,
    "茨城県":8,"栃木県":9,"群馬県":10,"埼玉県":11,"千葉県":12,"東京都":13,"神奈川県":14,
    "新潟県":15,"富山県":16,"石川県":17,"福井県":18,"山梨県":19,"長野県":20,
    "岐阜県":21,"静岡県":22,"愛知県":23,"三重県":24,
    "滋賀県":25,"京都府":26,"大阪府":27,"兵庫県":28,"奈良県":29,"和歌山県":30,
    "鳥取県":31,"島根県":32,"岡山県":33,"広島県":34,"山口県":35,
    "徳島県":36,"香川県":37,"愛媛県":38,"高知県":39,
    "福岡県":40,"佐賀県":41,"長崎県":42,"熊本県":43,"大分県":44,"宮崎県":45,"鹿児島県":46,"沖縄県":47,
    "未定": 48
  }, _prefix: true

  # 配送料の負担
  enum shipping_charge: {
    "---": 0, "送料込み(出品者負担)": 1, "着払い(購入者負担)": 2
  }, _prefix: true

  # 配送方法(着払い)
  enum delivery_chakubarai_types: {
    "未定": 1, "クロネコヤマト": 2, "ゆうパック": 3, "ゆうメール": 4
  }, _prefix: true

  # 配送方法(送料込み)
  # NOTE:着払いと重複しないidを設定
  enum delivery_soryokomi_types: {
    "未定": 5, "らくらくメルカリ便": 6, "ゆうメール": 7,
    "レターパック": 8, "普通郵便(定形、定形外)": 9, "クロネコヤマト": 10,
    "ゆうパック": 11, "クリックポスト": 12, "ゆうパケット": 13
  }, _prefix: true

  # 発送までの日数
  enum delivery_term: {
    "---": 0, "1~2日で発送": 1, "2~3日で発送": 2, "4~7日で発送": 3
  }, _prefix: true

  def previous
    Item.order('id desc')
        .where('id < ?', id)
        .first
  end

  def next
    Item.order('id desc')
        .where('id > ?', id)
        .reverse.first
  end
end
