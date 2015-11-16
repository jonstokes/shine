class Author < ActiveRecord::Base
  def self.hash_from_entry(author)
    {
      name: author.fields[:name],
      website: author.fields[:website],
      biography: author.fields[:biography],
      profile_photo: extract_asset(author.fields[:profilePhoto])
    }
  end
end