Given('a user') do
  @user = FactoryBot.create(:user)
end

Given('I am logged in as a user') do
  visit root_path
  fill_in 'email', with: @user.email
  fill_in 'password', with: @user.password
  click_button 'Login/Register'
end

When('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
end
