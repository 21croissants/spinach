require_relative 'filesystem'

module Integration
  module SpinachRunnerFromFeatureSteps

    def run_feature(command, options={})
      options[:framework] ||= :minitest
      use_minitest if options[:framework] == :minitest
      use_rspec if options[:framework] == :rspec
      run "../../bin/spinach-from-lib #{command} #{options[:append]}"
    end

  end
end
