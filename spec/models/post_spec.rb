require 'spec_helper'

describe Post do
  context "validations" do
    subject { create(:post) }

    it { is_expected.to be_valid }

    it "requires a cid" do
      subject.cid = nil
      expect(subject).not_to be_valid
    end

    it "requires a title" do
      subject.title = nil
      expect(subject).not_to be_valid
    end

    it "requires a slug" do
      subject.slug = nil
      expect(subject).not_to be_valid
    end

    it "requires a body" do
      subject.body = nil
      expect(subject).not_to be_valid
    end
  end

  describe "mapping attributes" do
    it "translates an post item into an attributes hash" do
      item = Content::Item.new load_request(type: "post", action: "publish")

      expect(Post.item_to_attributes(item)).to eq(
        cid:                "2gUGl8pte0ug8QwoisiiI0",
        title:              "This is a test entry",
        slug:               "this-is-a-test-entry",
        author_cids:        ["5JQ715oDQW68k8EiEuKOk8"],
        body:               "I am testing this entry.\n\n![Ernest Hemingway (1950)](//images.contentful.com/rwvjblw7dr6a/3S1ngcWajSia6I4sssQwyK/eacba4033620dcd5d36e985aa3271a55/Ernest_Hemingway_1950.jpg)\n\nThat is a picture of Papa.",
        category_cids:      ["6XL7nwqRZ6yEw0cUe4y0y6"],
        tags:               ["foo", "bar"],
        featured_image_cid: "2ReMHJhXoAcy4AyamgsgwQ",
        date:               "2015-11-17",
        comments:           true
      )
    end
  end
end