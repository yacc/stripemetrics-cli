require 'stripemetrics-cli'
require 'stripemetrics-cli/authorization'
require 'stripemetrics-cli/api_client'

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
  api_client = StripemetricsCli::ApiClient.new
  @auth = StripemetricsCli::Authorization.new(api_client)
  @auth.logout!
end

Given(/^that the app is authorized$/) do
  api_client = StripemetricsCli::ApiClient.new
  @auth = StripemetricsCli::Authorization.new(api_client)
  @auth.login!
end

Given(/^I run the following commands$/) do |table|
  @app_name = table.hashes["binary"]
  @com_name = table.hashes["command"]
  @com_options =  table.hashes["option"]
  step %(I run `#{@app_name} #{@com_name} #{@com_opt}`)
end

# ================= THENs ===================
Then(/^I should be logged in$/) do
  @auth.valid?
end
