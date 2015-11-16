class Category < ActiveRecord::Base
  def self.hash_from_entry(category)
    {
      title: category.fields[:title],
      short_description: category.fields[:shortDescription],
      icon: extract_asset(category.fields[:icon])
    }
  end
end