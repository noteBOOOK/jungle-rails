require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should save successfully' do
      @user = User.new(first_name: 'Jason', last_name: 'Long', email: 'test@test.com', password: "password", password_confirmation: "password")
      @user.save!
      expect(@user.id).to be_present
    end
    # Validations to check:
    # Created with password and password_confirmation fields
    it 'should contain password' do
      @user = User.new(first_name: 'Jason', last_name: 'Long', email: 'test@test.com', password: nil, password_confirmation: 'password')
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'should contain password_confirmation' do
      @user = User.new(first_name: 'Jason', last_name: 'Long', email: 'test@test.com', password: 'password', password_confirmation: nil)
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end
      # Both passwords also need to match
    it 'should have matching password and password_confirmation fields' do
      @user = User.new(first_name: 'Jason', last_name: 'Long', email: 'test@test.com', password: 'password1', password_confirmation: 'password2')
      @user.save
      expect(@user.errors.full_messages).to contain_exactly("Password confirmation doesn't match Password")
    end

    # Emails must be unique (not case sensitive comparison)
    it 'should contain a unique email' do
      @user = User.new(first_name: 'Jason', last_name: 'Long', email: 'test@test.com', password: 'password', password_confirmation: 'password')
      @user.save
      @user1 = User.new(first_name: 'Jason1', last_name: 'Long1', email: 'test@test.com', password: 'password1', password_confirmation: 'password1')
      @user1.save
      expect(@user1.errors.full_messages).to contain_exactly("Email has already been taken")
    end
    it 'email should be case-sensitive' do
      @user = User.new(first_name: 'Jason', last_name: 'Long', email: 'test@test.com', password: 'password', password_confirmation: 'password')
      @user.save
      @user1 = User.new(first_name: 'Jason1', last_name: 'Long1', email: 'TEST@test.com', password: 'password1', password_confirmation: 'password1')
      @user1.save
      expect(@user1.errors.full_messages).to contain_exactly("Email has already been taken")
    end
    # Email, first name and last name also required
    it 'should validate that first name is present' do
      @user = User.new(first_name: nil, last_name: 'Long', email: 'test@test.com', password: 'password', password_confirmation: 'password')
      @user.save
      expect(@user.errors.full_messages).to contain_exactly("First name can't be blank")
    end
    it 'should validate that last name is present' do
      @user = User.new(first_name: 'Jason', last_name: nil, email: 'test@test.com', password: 'password', password_confirmation: 'password')
      @user.save
      expect(@user.errors.full_messages).to contain_exactly("Last name can't be blank")
    end
    it 'should validate that email is present' do
      @user = User.new(first_name: 'Jason', last_name: 'Long', email: nil, password: 'password', password_confirmation: 'password')
      @user.save
      expect(@user.errors.full_messages).to contain_exactly("Email can't be blank")
    end
    # Password minimum length should be 4 characters
    it 'should validate minimum length of password to 4 characters' do
      @user = User.new(first_name: 'Jason', last_name: 'Long', email: 'test@test.com', password: 'pas', password_confirmation: 'pas')
      @user.save
      expect(@user.errors.full_messages).to contain_exactly("Password is too short (minimum is 4 characters)", "Password confirmation is too short (minimum is 4 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should authenticate email and password for login' do
      @user = User.new(first_name: 'Jason', last_name: 'Long', email: 'test@test.com', password: 'password', password_confirmation: 'password')
      @user.save
      @auth_user = User.authenticate_with_credentials('test@test.com', 'password')
      expect(@auth_user).to eq(@user)
    end
    it 'should fail to login if failed authentication' do
      @user = User.new(first_name: 'Jason', last_name: 'Long', email: 'test@test.com', password: 'password', password_confirmation: 'password')
      @user.save
      @auth_user = User.authenticate_with_credentials('test@test.com', 'superman')
      expect(@auth_user).to be_nil
    end

    it 'should log in correctly with case-insensitive email' do
      @user = User.new(first_name: 'Jason', last_name: 'Long', email: 'test@test.com', password: 'password', password_confirmation: 'password')
      @user.save
      @auth_user = User.authenticate_with_credentials('TEST@test.com', 'password')
      expect(@auth_user).to eq(@user)
    end

    it 'should strip spaces before and after email' do
      @user = User.new(first_name: 'Jason', last_name: 'Long', email: 'test@test.com', password: 'password', password_confirmation: 'password')
      @user.save
      @auth_user = User.authenticate_with_credentials(' test@test.com ', 'password')
      expect(@auth_user).to eq(@user)
    end
  end
end
