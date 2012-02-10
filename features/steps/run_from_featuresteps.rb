class RunFromFeaturesteps < Spinach::FeatureSteps
  feature 'Run from FeatureSteps'

  include Integration::SpinachRunner
  include Integration::SpinachRunnerFromFeatureSteps

  Given 'I have a feature that has some successful steps' do
    write_file('features/steps/test_feature.rb',
               'class ATestFeature < Spinach::FeatureSteps
          feature "A test feature"

          Given "I am a fool" do
          end

          When "I jump from Codegrams roof" do
          end

          Then "I must succeed" do
            true
          end
         end')
    @feature = "features/steps/test_feature.rb"
  end

  When 'I run it' do
    run_feature @feature
  end


  Then 'it should pass' do
    @stdout.must_match /Summary: \(3\) Successful/
  end
end