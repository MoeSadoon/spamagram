require 'rails_helper'

feature 'posts' do

  context 'no posts have been added' do
    scenario 'should display link to add a new post' do
      visit '/'
      expect(page).to have_content 'No posts yet'
      expect(page).to have_link 'Add Post'
    end
  end

  context 'post added' do
    scenario 'should display post on posts page' do
      visit '/'
      click_link 'Add Post'
      attach_file('Image', "spec/files/images/coffee.jpg")
      fill_in 'Caption', with: 'This is some nice java!'
      click_button 'Create Post'
      expect(page).to have_content 'This is some nice java'
      expect(page).to have_css("img[src*='coffee.jpg']")
      expect(page).not_to have_content 'No posts yet'
    end
  end


end
