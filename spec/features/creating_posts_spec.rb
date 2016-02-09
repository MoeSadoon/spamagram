require 'rails_helper'

feature 'posts' do

  context 'no posts have been added' do
    scenario 'should display link to add a new post' do
      visit '/'
      expect(page).to have_content 'No posts yet'
      expect(page).to have_link 'Add Post'
    end
  end

  context 'posts have been added' do
    before { create(:post, caption: 'My first post') }

    scenario 'homepage should display posts' do
      visit '/'
      expect(page).to have_content 'My first post'
      expect(page).not_to have_content 'No posts yet'
    end

  end

  context 'user adding post' do
    scenario 'should not be able to post without uploading image' do
      visit '/'
      click_link 'Add Post'
      fill_in 'Caption', with: "no image lol"
      click_button 'Create Post'
      expect(page).to have_content 'You need to upload an image'
    end

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

  context 'viewing individual posts' do
    before { create(:post, caption: 'My first post') }

    scenario 'should be able to go to individual post by clicking on image' do
      visit '/'
      find(:xpath, "//a[contains(@href,'posts/1')]").click
      # expect(page.current_path).to eq(post_path(post))
      # expect(page).to have_content 'My first post'

    end

  end


  # context 'editing posts' do
  #   before { create(:post, caption: 'I should really edit this') }
  #
  #   scenario 'should be able to edit existing post' do
  #     visit '/'
  #     click_link 'Edit post'
  #
  #
  #   end





end
