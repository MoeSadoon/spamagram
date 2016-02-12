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

end
