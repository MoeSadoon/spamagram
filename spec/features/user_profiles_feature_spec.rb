require 'rails_helper'

feature 'User profiles' do
  before { @user = create :user
            @user.posts.create(caption: 'user1 post',
            image: Rack::Test::UploadedFile.new(Rails.root + 'spec/files/images/coffee.jpg', 'image/jpg')
            )
           @user2 = create :user, username: 'tester2', email: 'test2@hotmail.com'
             @user2.posts.create(caption: 'user2 post',
             image: Rack::Test::UploadedFile.new(Rails.root + 'spec/files/images/coffee.jpg', 'image/jpg')
             )
  }

  context 'visiting a user\'s profile' do
    it 'should be able to click on user name to go to their profile' do
      visit '/'
      click_link "#{@user.username}"
    end

    it 'should only see user\'s posts on their page' do
      visit "/#{@user.username}"
      expect(page).to have_content 'user1 post'
      expect(page).not_to have_content 'user2 post'
    end
  end

  context 'editing user profiles' do
    it 'should be able to edit their profile details' do
      sign_in(@user)
      visit "/#{@user.username}"
      click_link 'Edit Profile'
      fill_in 'user_bio', with: 'I am user1'
      click_button 'Update Profile'
      expect(current_path).to eq "/#{@user.username}"
      expect(page).to have_content 'Your profile has been updated'
      expect(page).to have_content 'I am user1'
    end

    it 'should not be able to edit other user\'s profiles' do
      sign_in(@user2)
      visit "/#{@user.username}/edit"
      expect(current_path).to eq root_path
      expect(page).to have_content 'You cannot edit this!'
    end
  end



end
