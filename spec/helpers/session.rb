module SessionHelpers

  def sign_up
    visit '/'
    click_link 'Register'
    fill_in 'Username', with: 'TestUser'
    fill_in 'Email', with: 'tester@test.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
  end


  def sign_in(user)
    visit '/users/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  def user_creates_post
    visit '/'
    click_link 'Add Post'
    attach_file('Image', "spec/files/images/coffee.jpg")
    fill_in 'Caption', with: 'This is some nice java!'
    click_button 'Create Post'
    visit "/posts/#{@user.posts.first.id}"
  end
end
