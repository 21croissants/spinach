Feature: Run from FeatureSteps
  In order to save time when writing feature text (synch the .feature & .rb file is no fun and feels unDRY)
  As a test writer
  I want to spike if I can tweak the FeatureRunner to run from a Spinach::FeatureSteps class

  Or shall I juse use https://github.com/elight/coulda ?

  UML sequence diagram for current Spinach Runner is:


  bin/spinach->Cli: run
  Cli->Runner: run
  Runner->Parser: open_file(filename).parse
  Runner->FeatureRunner: new(Spinach::Feature).run
  FeatureRunner->FeatureRunner: run_scenarios!
  FeatureRunner->ScenarioRunner: new(Gherkin::AST::Scenario).run
  ScenarioRunner->ScenarioRunner:run_step(Gherkin::AST::Step)
  ScenarioRunner->FeatureSteps: step_location_for(step.name)
  FeatureSteps->DSL: execute(step location)
  DSL->Support: underscore(step.name)
  DSL->DSL: send(underscored_step)
  note right of DSL: underscored_step is the method name for the Given/When step block and CAN contain white spaces !

  http://www.websequencediagrams.com/?lz=YmluL3NwaW5hY2gtPkNsaTogcnVuCiAgQ2xpLT5SdW5uZXIACwgACAYtPlBhcnNlcjogb3Blbl9maWxlKGZpbGVuYW1lKS5wYXJzZQAhC0ZlYXR1cmUAQQhuZXcoR2hlcmtpbjo6QVNUOjoAGgcpLgBxBgAjDQAuEXJ1bl9zY2VuYXJpb3MhAB0SUwAVBwBVGgAaCABoCAAkDgAxEQBsBXRlcAA2EHRlcCkAKxMAgWcHU3RlcHM6IHN0ZXBfbG9jYXRpb25fZm9yKHN0ZXAuAIIkBQCBYQoAKAUtPkRTTDogZXhlY3V0ZQAjBSAAMggpCiAgRFNMLT5TdXBwb3J0OiB1bmRlcnNjb3IAJAYASQkAIQUARAVzZW5kKAAdCmQAgUAFKQogIG5vdGUgcmlnaHQgb2YgAHAFABcQIGlzIHRoZSBtZXRob2QgbmFtZSBmb3IADwVHaXZlbi9XaGVuAIFZBSBibG9jayBhbmQgQ0FOIGNvbnRhaW4gd2hpdGUgc3BhY2VzICEK&s=roundgreen

  Proposal is:

  bin/spinach->Cli: run
  Cli->Runner: run
  Runner->FeatureRunner: new(FeatureSteps class).run

  FeatureRunner->FeatureRunner: run_scenarios!
  FeatureRunner->ScenarioRunner: new(Spinach::Scenario).run
  ScenarioRunner->FeatureSteps: find_steps
  ScenarioRunner->FeatureSteps: run_step(Spinach::Step)

  http://www.websequencediagrams.com/?lz=YmluL3NwaW5hY2gtPkNsaTogcnVuCiAgQ2xpLT5SdW5uZXIACwgACAYtPkZlYXR1cmUAFQhuZXcoAAwHU3RlcHMgY2xhc3MpLgBCBgAgDQArEXJ1bl9zY2VuYXJpb3MhAB0SUwAVBwBgDFMAgSgGOjoAFQgAYwgAHw4AgR8JAIEQBTogZmluZF9zdGVwcwAKIQCBEQV0ZXAAYAt0ZXAp&s=roundgreen

  Scenario: Spike
    Given I have a feature that has some successful steps
    When I run it
    Then it should pass
