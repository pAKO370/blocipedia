require 'rails_helper'

describe ChargesController do
  describe '#downgrade' do
    let(:other_user) { User.new(email: 'other_user@example.com', password: '12345678') }
    let(:user) { User.new(email: 'user@example.com', password: '12345678', role: :premium) }
    let(:owned_private_wiki) { Wiki.create!(private: true, user: user) }
    let(:unowned_private_wiki) { Wiki.create!(private: true, user: other_user) }

    before do
      user.skip_confirmation!
      user.save!
      other_user.skip_confirmation!
      other_user.save!
    end

    before do
      owned_private_wiki
      unowned_private_wiki
    end

    it 'downgrades the user' do
      put :downgrade, {user_id: user.id}
      user.reload
      expect(user.role).to eq('standard')
    end

    it "makes the user's private wikis public" do
      put :downgrade, {user_id: user.id}
      owned_private_wiki.reload
      expect(owned_private_wiki.private).to eq(false)
    end

    it "doesn't make other user's private wikis public" do
      put :downgrade, {user_id: user.id}
      unowned_private_wiki.reload
      expect(unowned_private_wiki.private).to eq(true)
    end
  end
end