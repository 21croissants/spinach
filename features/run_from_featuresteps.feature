Feature: Run from FeatureSteps
  In order to save time when writing feature text (synch the .feature & .rb file is no fun and feels unDRY)
  As a test writer
  I want to spike if I can tweak the FeatureRunner to run from a Spinach::FeatureSteps class

  http://www.websequencediagrams.com/ for current Spinach Runner is:

  bin/spinach->Cli: run
  Cli->Runner: run
  Runner->FeatureRunner: new(feature_file).run
  FeatureRunner->FeatureRunner: run_scenarios!
  FeatureRunner->ScenarioRunner: new(Gherkin::AST::Scenario).run
  ScenarioRunner->ScenarioRunner:run_step(Gherkin::AST::Step)
  ScenarioRunner->FeatureSteps: step_location_for(step.name)
  FeatureSteps->DSL: execute(step location)
  DSL->Support: underscore(step.name)
  DSL->DSL: send(underscored_step)
  note right of DSL: underscored_step is the method name for the Given/When step block and CAN contain white spaces !

  Proposal is: TODO

  Scenario: Spike
    Given I have a feature that has some successful steps
    When I run it
    Then it should pass
