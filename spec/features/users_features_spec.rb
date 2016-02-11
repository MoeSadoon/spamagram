require 'rails_helper'

feature 'users' do

  context 'not signed in' do
    it 'should display login or register link' do
      visit '/'
      expect(page).to have_link 'Login'
      expect(page).to have_link 'Register'
    end

    it 'should not se sign out link' do
      visit '/'
      expect(page).not_to have_link 'Sign out'
    end
  end

  context 'user signed up' do
    it 'should not see sign out link' do
      visit '/'
      expect(page).to have_link 'Sign out'
    end

    it 'should not see login or register link' do
      visit '/'
      expect(page).not_to have_link 'Login'
      expect(page).not_to have_link 'Register'
    end
  end




end
