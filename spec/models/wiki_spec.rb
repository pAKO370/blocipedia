require 'rails_helper'

describe Wiki do
  describe '.visible_to' do
    let(:other_user) { User.new(email: 'other_user@example.com', password: '12345678') }
    let(:owned_private_wiki) { Wiki.create!(private: true, user: user) }
    let(:unowned_private_wiki) { Wiki.create!(private: true, user: other_user) }
    let(:public_wiki) { Wiki.create!(private: false, user: other_user) }
    

    before do
      user.skip_confirmation!
      user.save!
      other_user.skip_confirmation!
      other_user.save!
    end

    context 'for an admin user' do
      let(:user) { User.new(email: 'admin@example.com', password: '12345678', role: :admin) }

      it 'returns all wikis' do
        expect(Wiki.visible_to(user)).to include(owned_private_wiki, unowned_private_wiki, public_wiki)
      end
    end

    context 'for a premium user' do
      let(:user) { User.new(email: 'admin@example.com', password: '12345678', role: :premium) }

      it 'does not return unowned private wikis' do
        expect(Wiki.visible_to(user)).to_not include(unowned_private_wiki)
      end

      it 'returns owned and public wikis' do
        expect(Wiki.visible_to(user)).to include(owned_private_wiki, public_wiki)
      end
    end

    context 'for a standard user' do
      let(:user) { User.new(email: 'admin@example.com', password: '12345678', role: :standard) }

      it 'does not return private wikis' do
        expect(Wiki.visible_to(user)).to_not include(unowned_private_wiki, owned_private_wiki)
      end

      it 'returns public wikis' do
        expect(Wiki.visible_to(user)).to include(public_wiki)
      end
    end
  end
end
