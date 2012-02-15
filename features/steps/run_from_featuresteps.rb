class RunFromFeaturesteps < Spinach::FeatureSteps
  feature 'Run from FeatureSteps'

  include Integration::SpinachRunner

  Given 'I have a feature that has some successful steps' do
    write_file('features/steps/test_feature.rb',
               'class TestFeature < Spinach::FeatureSteps
          feature "Test feature"

          Scenario "Codegram really rocks!" do

            Given "I am a fool" do
            end

            When "I jump from Codegrams roof" do
            end

            Then "I must succeed" do
              true
            end

          end
        end')
    @feature = "features/steps/test_feature.rb"
  end


  When 'I run it' do
    run_steps @feature
  end

  Then 'it should pass' do
    @stdout.must_match /Summary: \(3\) Successful/
  end

  def run_steps(command, options={})
    options[:framework] ||= :minitest
    use_minitest if options[:framework] == :minitest
    use_rspec if options[:framework] == :rspec
    run "../../bin/spinach-from-lib #{command} #{options[:append]}"
  end
end