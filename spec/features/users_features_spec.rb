require 'rails_helper'

feature 'users' do

  context 'not signed in' do
    it 'should display login or register link' do
      visit '/'
      expect(page).to have_link 'Login'
      expect(page).to have_link 'Register'
    end

    it 'should not see sign out link' do
      visit '/'
      expect(page).not_to have_link 'Sign out'
    end
  end

  context 'user signed up' do
    before(:each) {
      @user = create(:user)
      sign_in(@user)
    }

    it 'should see sign out link' do
      visit '/'
      expect(page).to have_link 'Logout'
    end

    it 'should not see login or register link' do
      visit '/'
      expect(page).not_to have_link 'Login'
      expect(page).not_to have_link 'Register'
    end
  end




end
