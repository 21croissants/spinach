module Spinach
  # Runner gets the parsed data from the feature and performs the actual calls
  # to the feature classes.
  #
  class SpikeRunner < Runner

    # Runs this runner and outputs the results in a colorful manner.
    #
    # @return [true, false]
    #   Whether the run was succesful.
    #
    # @api public
    def run
      require_dependencies
      require_frameworks

      Spinach.hooks.run_before_run

      successful = true

      filenames.map do |filename|
        filename.split(':')
      end.each do |filename, line|

        # Spinach Runner uses a simple Gherkin parser made in codegram to get an
        # array of Gherkin::AST::Scenario
        #feature = Parser.open_file(filename).parse

        feature = nil # TODO Parse FeatureSteps class to generate a Gherkin::AST::Scenario, sounds very dirty ...

        success = FeatureRunner.new(feature, line).run
        successful = false unless success
      end

      Spinach.hooks.run_after_run(successful)

      successful
    end

  end

end

