module MobileStepsHelper
  SAMPLE_AGENT_STRING = {
    "iPhone" => "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_0 like Mac OS X; en-us) AppleWebKit/532.9 (KHTML, like Gecko) Version/4.0.5 Mobile/8A293 Safari/6531.22.7",
    "Android" => "HTC_Eris Mozilla/5.0 (Linux; U; Android 4.0; en-ca; Build/GINGERBREAD) AppleWebKit/528.5+ (KHTML, like Gecko) Version/3.1.2 Mobile Safari/525.20.1"
  }
end
World(MobileStepsHelper)
 
Given /^my user agent is "(.+)"$/ do |agent|
  add_headers({'User-Agent'=> agent})
end
 
Given /^I have an? (.+)$/ do |phone_name|
  add_headers("User-Agent" => MobileStepsHelper::SAMPLE_AGENT_STRING[phone_name])
  page.driver.resize_window(320,416)
end

When /^I enter "(.+)" in the responder box$/ do |search_text|
  find(:css, "input[data-type$='search']").set(search_text)
  within('#frontResponder') do
    page.should have_content(search_text)
  end
end

Then /^the roster should show (\d+) responders \((\d+) active\)$/ do |cnt,act|
  find('#frontRosterCount').should have_content("#{act} / #{cnt}")
end

When /^I pick "(.+)" for "(.+)"$/ do |val,field|
  select(val, :from => field)
end
