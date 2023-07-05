Given('I am on the home page') do
  visit root_path
end

When('I fill in email with user email') do
  fill_in 'email', with: @user.email
end

When('I fill in email with {string}') do |email|
  fill_in 'email', with: email
end

When('I fill in password with {string}') do |password|
  fill_in 'password', with: password
end

When('I click the {string} button') do |button_text|
  click_button button_text
end

Then('I should be on the home page') do
  expect(page).to have_current_path(root_path, ignore_query: true)
end

Then('I should see text welcome my email') do
  expect(page).to have_content("Welcome #{@user.email}")
end

Then('I should see an error message {string}') do |error_message|
  expect(page.html).to include("toastr.error(\"#{error_message}\");")
end
