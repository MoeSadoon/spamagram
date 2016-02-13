require 'rails_helper'

feature 'Comments' do
  before { @user = create :user
           sign_in @user
           user_creates_post
  }

  context 'user adding comments' do
    it 'should be able to comment on a post' do
      visit '/'
      fill_in 'comment_content', with: 'Wow'
      click_button 'Create Comment'
      expect(page).to have_content 'Wow'
    end
  end



end
