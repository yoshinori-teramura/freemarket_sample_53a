FactoryBot.define do

  factory :user do
    nickname              {"test.app"}
    email                 {"test@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
    family_name           {"test"}
    first_name            {"test"}
    family_kana_name      {"テスト"}
    first_kana_name       {"テスト"}
    birthday              {"2019-01-01"}
    tel                   {"08012345678"}
  end

end