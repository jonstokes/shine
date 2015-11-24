FactoryGirl.define do
  factory :asset, class: Shine::Asset do
    file {
      {
        :fileName => "lewis-carroll-1.jpg",
        :contentType => "image/jpeg",
        :details => {:image => {:width => 300, :height => 250}, :size => 21113},
        :url => "//images.contentful.com/rwvjblw7dr6a/2ReMHJhXoAcy4AyamgsgwQ/30a953013843db486c9adcc6282843d9/lewis-carroll-1.jpg"
      }
    }
    sequence(:title)       { |n| "Title #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    user
  end

  factory :user, class: Shine::User do
    sequence(:name)               { |n| "Name #{n}" }
    sequence(:biography)          { |n| "My bio #{n}"  }
    sequence(:email)              { |n| "user#{n}@example.com" }
    sequence(:password)           { |n| "password#{n}" }
    role                          { 'editor' }
  end

  factory :category, class: Shine::Category do
    sequence(:title) { |n| "Title #{n}" }
    icon_id          { create(:asset).id }
  end

  factory :post, class: Shine::Post do
    sequence(:title)   { |n| "Title #{n}" }
    sequence(:slug)    { |n| "#{title.underscore}-#{n}" }
    user_ids           { [create(:user).id] }
    sequence(:excerpt) { |n| "Excerpt #{n}" }
    sequence(:body)    { |n| "Body #{n}" }
    category_ids        { [create(:category).id] }
    sequence(:tags)    { |n| ["tag_#{n}"] }
    featured_image_id  { create(:asset).id }
    comments           { true }
    status             { 'published' }
  end
end