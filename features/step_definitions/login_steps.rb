require 'selenium-webdriver'

driver = Selenium::WebDriver.for :firefox

Given(/^I am on the login page$/) do
  
  driver.navigate.to 'https://ukit.com/ru#signIn'
end

When(/^I provide the email address "([^"]*)"$/) do |arg1|
  login_field = driver.find_element(:id, 'sign_in_email')
  login_field.send_keys 'some@mail.ru'
end

When(/^I provide the password "([^"]*)"$/) do |arg1|
  pw_field = driver.find_element(:id, 'sign_in_password')
  pw_field.send_keys 'password'
end

Then(/^I should be successfully logged in$/) do
  pw_field = driver.find_element(:id, 'sign_in_btn')
  pw_field.send_keys password
end