FactoryBot.define do
  factory :post do
    title { 'テスト投稿' }
    summary { '要約のテスト投稿' }
    description { '詳細のテスト投稿' }
    category_name { '福祉' }
    url { 'test.com' }
    user
  end
end