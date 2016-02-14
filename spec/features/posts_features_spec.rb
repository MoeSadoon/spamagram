require 'rails_helper'

feature 'Posts' do
  before { @user = create :user
           sign_in @user
           @user2 = create :user, email: 'test2@hotmail.com'
  }

  context 'no posts have been added' do
    it 'should display link to add a new post' do
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
    it 'should not be able to post without uploading image' do
      visit '/'
      click_link 'Add Post'
      fill_in 'Caption', with: "no image lol"
      click_button 'Create Post'
      expect(page).to have_content 'You need to upload an image'
    end

    it 'should not be able to post a caption less than 3 characters' do
      visit '/'
      click_link 'Add Post'
      attach_file('Image', "spec/files/images/coffee.jpg")
      fill_in 'Caption', with: "zy"
      click_button 'Create Post'
      expect(page).to have_content 'is too short'
      expect(page).not_to have_content 'zy'
    end

    it 'should display post on posts page' do
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

  context 'dealing with individual posts' do
    before { user_creates_post }

    it 'should be able to view individual post on own page' do
      expect(page.current_path).to eq("/posts/#{@user.posts.first.id}")
      expect(page).to have_content 'This is some nice java!'
      expect(page).to have_css("img[src*='coffee.jpg']")
    end

    it 'should be able to edit existing post' do
      click_link 'Edit Post'
      fill_in 'Caption', with: "You weren't supposed to see this!"
      click_button 'Update Post'
      expect(page).to have_content 'Post successfully updated'
      expect(page).to have_content "You weren't supposed to see this!"
    end

    it 'should only be able to edit their own posts' do
      click_link 'Logout'
      sign_in @user2
      visit "/posts/#{@user.posts.first.id}"
      expect(page).not_to have_link 'Edit Post'
      visit "/posts/#{@user.posts.first.id}/edit"
      expect(page).to have_content 'That post does not belong to you!'
    end

    it 'should be able to delete a post' do
      click_link 'Edit Post'
      click_link 'Delete Post'
      expect(page.current_path).to eq(root_path)
      expect(page).to have_content 'Post successfully deleted'
      expect(page).not_to have_content 'My first post'
    end
  end

end
