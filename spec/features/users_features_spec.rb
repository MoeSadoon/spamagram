require 'rails_helper'

feature 'users' do

  context 'not signed in' do
    it 'should display sign in or register link' do
      visit '/'
      expect(page).to have_link 'Sign in'
      expect(page).to have_link 'Register'
    end
  end




end
