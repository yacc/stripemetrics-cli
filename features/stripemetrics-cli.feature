Feature: StripeMetrics is awesome
  In order to make user happy
  I want to have an awesome cli app
  So they don't have to do it themselves

  Scenario: App just runs
    When I get help for "stripemetrics-cli"
    Then the exit status should be 0
