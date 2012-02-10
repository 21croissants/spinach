Feature: Run from FeatureSteps
  In order to save time when writing feature text and DRY the steps text
  As a test writer
  I want to spike if I can tweak the FeatureRunner to run from a Spinach::FeatureSteps class

  Scenario: Spike
    Given I have a feature that has some successful steps
    When I run it
    Then it should pass
