When('I click on the {string} button') do |button_text|
  click_on(button_text)
end

Then('I should not see the {string} button') do |button_text|
  expect(page).not_to have_button(button_text)
end

Then('I should be redirected to the home page') do
  expect(page).to have_current_path(root_path)
end

Then('I should see the message {string}') do |message|
  expect(page.html).to include("toastr.success(\"#{message}\");")
end

Then('I should not see the message {string}') do |message|
  expect(page.html).not_to include("toastr.success(\"#{message}\");")
end
