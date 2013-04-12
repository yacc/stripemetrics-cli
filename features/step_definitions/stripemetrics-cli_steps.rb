require 'stripemetrics'

# ================= WHENs ===================
When /^I get help for "([^"]*)"$/ do |app_name|
  @app_name = app_name
  step %(I run `#{app_name} help`)
end

When /^I get help for "([^"]*)" for the command "([^"]*)"$/ do |app_name,com_name|
  @app_name = app_name
  @com_name = com_name
  step %(I run `#{app_name} help #{com_name}`)
end


# ================= GIVENs ===================
Given(/^that the app is not authorized$/) do
  @client = nil
end

Given(/^that the app is authorized$/) do
  @client ||= Stripemetrics::Client.new
end

Given(/^I run the following commands$/) do |table|
  @app_name = table.hashes["binary"]
  @com_name = table.hashes["command"]
  @com_options =  table.hashes["option"]
  step %(I run `#{@app_name} #{@com_name} #{@com_opt}`)
end

# ================= THENs ===================
Then(/^I the app should log me in$/) do
  # stub_request(:post, 'http://api.stripemetrics.dev/v1/auth/tokens').to_return do |request|
  #   {:token => 'fewfwefwefwfe', :status => 200}
  # end
end
