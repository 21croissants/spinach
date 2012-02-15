require_relative 'parser/spike_feature_steps_parser'

module Spinach

  class SpikeRunner < Runner
    def initialize(filenames, options = {})
      @parser_class = SpikeFeatureStepsParser
      super
    end
  end

end

