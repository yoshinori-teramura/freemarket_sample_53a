FactoryBot.define do

  factory :item do
    name                  {"商品test"}
    description           {"test商品の詳細です。"}
    image                 {File.open("#{Rails.root}/app/assets/images/member_photo_noimage_thumb.png")}
    price                 {"50000"}
    item_status           {1}
    trade_status          {1}
    delivery_region       {13}
    shipping_charge       {1}
    delivery_type         {1}
    delivery_days         {1}
    id                    {"1"}
    category
    user
  end
end
