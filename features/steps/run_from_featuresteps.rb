class RunFromFeaturesteps < Spinach::FeatureSteps
  feature 'Run from FeatureSteps'

  include Integration::SpinachRunner

  Given 'I have a feature that has some successful steps' do
    raise 'step not implemented'
  end

  When 'I run it' do
    raise 'step not implemented'
  end

  Then 'I should see a summary with steps status information' do
    raise 'step not implemented'
  end
end