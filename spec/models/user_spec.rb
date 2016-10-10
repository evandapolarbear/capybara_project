require 'rails_helper'

RSpec.describe User, type: :model do
  user = FactoryGirl.create(:user, username: "bob", password: 'bob123')

  describe 'username' do
    it 'has username' do
      expect(user.username).to_not be_nil
    end

  end

  describe 'password validations' do
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe 'associations' do
      it { should have_many(:goals) }
  end
end
