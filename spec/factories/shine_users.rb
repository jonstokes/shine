FactoryGirl.define do
  factory :shine_user, class: 'Shine::User' do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:encrypted_password) { |n| "password#{n}" }
    role { 'editor' }
    sequence(:biography) { |n| "Biography #{n}" }
  end

  factory :shine_asset, class: 'Shine::asset' do
    user { create(:user) }
    sequence(:title) { |n| "Title #{n}" }
  end

end
