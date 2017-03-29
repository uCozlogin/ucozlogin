require 'cucumber/formatter/unicode' 
require 'capybara' 
require 'capybara/dsl' 
require 'capybara/session' 
require 'selenium-webdriver' 
require 'capybara/cucumber' 
require 'capybara/mechanize/cucumber'

Capybara.ignore_hidden_elements = true 
Capybara.default_wait_time = 15 
Capybara.app_host = 'http://my_site.com'

Capybara.register_driver :selenium do |app| 
    profile = Selenium::WebDriver::Firefox::Profile.new 
    Selenium::WebDriver::Firefox.path = File.expand_path('~/path/to/firefox') 
    Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => profile) 
end

Capybara.register_driver :mechanize do |app| 
    Capybara::Mechanize::Driver.new(app) 
end


Before do |scenario| 
  if scenario.source_tag_names.include?('@no_browser') and Capybara.default_driver != :mechanize 
      Capybara.default_driver = :mechanize 
  elsif !scenario.source_tag_names.include?('@no_browser') and Capybara.default_driver != :selenium 
      Capybara.default_driver = :selenium 
  end 
end 

After do |scenario| 
    if scenario.failed? 
        puts scenario.name
        puts scenario.exception.message        
    end 
end