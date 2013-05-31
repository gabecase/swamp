Feature: user scans fields in a page

  The user enters an url to a given page, swamp fires up the browser and go to that url
  once the page is loaded swamp start looking for fields then swamp generates the code
  snippets to interact with those elements using capybara.

  Background: swamp is running
    Given that swamp is already running

  Scenario: A standard field
    Given user types the file "field.html"
    When swamp scans that url
    Then swamp should output the following code snippet
      """
      def type_username(input)
        source.fill_in("id_username", with: input)
      end
      """

  Scenario: A field without the id attribute
    Given user types the file "field_without_id.html"
    When swamp scans that url
    Then swamp should output the following code snippet
      """
      def type_username(input)
        source.fill_in("username", with: input)
      end
      """

  Scenario: A checkbox
    Given user types the file "checkbox.html"
    When swamp scans that url
    Then swamp should not output any snippet

  Scenario: A radio
    Given user types the file "radio.html"
    When swamp scans that url
    Then swamp should not output any snippet
