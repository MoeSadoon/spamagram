require 'rails_helper'

feature 'posts' do

  context 'no posts have been added' do
    scenario 'should display link to add a new post' do
      visit '/'
      expect(page).to have_content 'No posts yet'
      expect(page).to have_link 'Add Post'
    end
  end


end
