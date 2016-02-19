FactoryGirl.define do
  factory :user do
    username 'testuser'
    email 'test@email.com'
    password 'password'
    password_confirmation 'password'
  end

end
