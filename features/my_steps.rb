
Given /^there is an active mission "(.*?)"$/ do |title|
	FactoryGirl.create(:mission, :title => title)
end

Given /^I am on the homepage$/ do
  visit '/'
end

When /^I follow "(.*?)"$/ do |link|
	click_link(link)
end

When /^I submit a log message "(.*?)"$/ do |msg|
	fill_in('newMsg', :with => msg)
	click_button('saveLogButton')
end

Then /^the page should show a log message "(.*?)"$/ do |text|
	page.find('#logTable').should have_content(text)
end

Then /^the page should report an invalid log message\.$/ do
  page.should have_content("can't be blank")
end

When /^I take a screenshot$/ do
	screenshot_and_save_page
end
