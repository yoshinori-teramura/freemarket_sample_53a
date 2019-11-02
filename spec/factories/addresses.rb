FactoryBot.define do

  factory :address do
    postal_code           {"1234567"}
    city                  {"テスト区"}
    block                 {"テスト1-2-3"}
    building_name         {"テストビル303"}
    delivery_family_name  {"test-address"}
    delivery_first_name   {"test-address"}
    delivery_family_kana_name {"テストアドレス"}
    delivery_first_kana_name  {"テストアドレス"}
    delivery_tel          {"08012345678"}
    prefecture_id         {"12"}
    
  end
end
