Given /^swamp is not yet running$/  do
end

When /^(?:I start it|that swamp is already running)$/  do
  swamp.run
end

Then /^I should see "(.*?)"$/  do |outcome|
  output.messages.should include(outcome)
end

Given /^user types the url "(.*?)"$/  do |url|
  @url = url
end

Given /^user types the file "(.*?)"$/  do |file|
  path = File.join(File.dirname(__FILE__), '../support/page_examples/', file)
  @url = "file://#{path}"
end

When /^swamp scans that url$/ do
  swamp.scan(@url)
end

Then /^swamp should output the following code snippets?$/ do |string|
  output.messages.should include(string)
end

Then /^swamp should not output any snippet$/ do
  prompt_message = "Enter the url for the page to be scanned:"
  output.messages.length.should == 1
  output.messages.should include(prompt_message)
end


class Output
  def messages
    @messages ||= []
  end

  def puts(message)
    messages << message
  end
end

def output
  @output ||= Output.new
end

def buttons
  Swamp::Buttons.new
end

def fields
  Swamp::Fields.new
end

def input_buttons
  Swamp::InputButtons.new
end

def wrapper
  Swamp::Wrapper.new(fields, buttons, input_buttons)
end

def swamp
  @swamp ||= Swamp::Interface.new(output, wrapper)
end
