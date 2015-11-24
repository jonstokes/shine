require 'spec_helper'

describe Shine::Post do
  context "validations" do
    subject { create(:post) }

    it { is_expected.to be_valid }

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

  context "relations" do
    describe "users" do
      let(:user1) { create(:user) }
      let(:user2) { create(:user) }

      it "has multiple users" do
        post = create(:post, user_ids: [user1.id, user2.id])
        expect(post.users.first).to eq(user2)
        expect(post.users.last).to eq(user1)
      end
    end
  end
end