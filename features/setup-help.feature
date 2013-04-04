Feature: Help for setup command
  In order to understand the setup command
  I want to see relevant help on the setup command

  Scenario: 
    When I get help for "stripemetrics-cli" for the command "login"
    Then the output should contain "Login and authorize with StripeMetrics.com"
    And the exit status should be 0

