require 'rails_helper'

feature 'User profiles' do

  context 'visiting a user\'s profile' do
    before { @user = create :user
              @user.posts.create(caption: 'user1 post',
              image: Rack::Test::UploadedFile.new(Rails.root + 'spec/files/images/coffee.jpg', 'image/jpg')
              )
             @user2 = create :user, username: 'tester2', email: 'test2@hotmail.com'
               @user2.posts.create(caption: 'user2 post',
               image: Rack::Test::UploadedFile.new(Rails.root + 'spec/files/images/coffee.jpg', 'image/jpg')
               )
    }

    it 'should be able to click on user name to go to their profile' do
      visit '/'
      click_link "#{@user.username}"
      expect(current_path).to eq "/#{@user.username}"
    end

    it 'should only see user\'s posts on their page' do
      visit "/#{@user.username}"
      expect(page).to have_content 'user1 post'
      expect(page).not_to have_content 'user2 post'
    end
  end

end
