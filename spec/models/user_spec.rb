require 'rails_helper'

RSpec.describe User, type: :model do
  email, username, password, password_confirmation = "test@test.com","dominathan","password","password"
  context 'creating a user' do
    it 'should require a username to save' do
      user = User.new(email: email, password: password)
      expect(user.save).to eq(false)
    end

    it 'cannot have duplicate usernames' do
      user1 = User.new(email: email, username: username, password: password)
      user2 = User.new(email: "newemail@test.com", username: username, password: password)
      expect(user1.save).to be_truthy
      expect(user2.save).to be false
    end

    it 'cannot have duplicate emails' do
      user1 = User.new(email: email, username: username, password: password)
      user2 = User.new(email: email, username: 'newusername', password: password)
      expect(user1.save).to be_truthy
      expect(user2.save).to be false
    end

    it 'should have 40000 fake_money after creation' do
      user = User.new(email: email, username: username, password: password)
      expect(user.save).to be(true)
      expect(user.fake_money).to be(40000)
    end
  end
end
