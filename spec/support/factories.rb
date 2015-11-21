FactoryGirl.define do
  factory :asset, class: Shine::Asset do
    transient do
      file_properties { {} }
    end
    cid { SecureRandom.uuid }
    file {
      {
        :fileName => "lewis-carroll-1.jpg",
        :contentType => "image/jpeg",
        :details => {:image => {:width => 300, :height => 250}, :size => 21113},
        :url => "//images.contentful.com/rwvjblw7dr6a/2ReMHJhXoAcy4AyamgsgwQ/30a953013843db486c9adcc6282843d9/lewis-carroll-1.jpg"
      }.merge(file_properties)
    }
    sequence(:title) { |n| "Title #{n}" }
    sequence(:description) { |n| "Description #{n}" }
  end

  factory :author, class: Shine::Author do
    cid { SecureRandom.uuid }
    sequence(:name) { |n| "Name #{n}" }
    sequence(:website) { |n| "http://twitter.com/#{n}" }
    profile_photo_cid { create(:asset).cid }
    sequence(:biography) { |n| "My bio #{n}"  }
  end

  factory :category, class: Shine::Category do
    cid { SecureRandom.uuid }
    sequence(:title) { |n| "Title #{n}" }
    icon_cid { create(:asset).cid }
  end

  factory :post, class: Shine::Post do
    cid { SecureRandom.uuid }
    sequence(:title) { |n| "Title #{n}" }
    sequence(:slug) { |n| "#{title.underscore}-#{n}" }
    author_cids { [create(:author).cid] }
    sequence(:excerpt) { |n| "Excerpt #{n}" }
    sequence(:body) { |n| "Body #{n}" }
    category_cids { [create(:category).cid] }
    sequence(:tags) { |n| ["tag_#{n}"] }
    featured_image_cid { create(:asset).cid }
    date { Date.current }
    comments { true }
  end
end