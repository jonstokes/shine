require 'spec_helper'

describe Shine::Category do
  context "validations" do
    subject { create(:category) }

    it { is_expected.to be_valid }

    it "requires a title" do
      subject.title = nil
      expect(subject).not_to be_valid
    end
  end

  context "relations" do
    it "has multiple posts" do
      category1 = create(:category)
      category2 = create(:category)

      create(:post, category_ids: [category1.id, category2.id])
      create(:post, category_ids: [category1.id, category2.id])
      create(:post, category_ids: [category1.id])

      expect(category2.posts.count).to eq(2)
      expect(category1.posts.count).to eq(3)      
    end
  end
end