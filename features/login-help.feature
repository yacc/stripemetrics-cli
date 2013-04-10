Feature: Help for login command
  In order to understand the login command
  I want to see help on the login command

  Scenario: 
    When I get help for "stripemetrics-cli" for the command "login"
    Then the output should contain "Login and authorize with StripeMetrics.com"
    And the exit status should be 0

