module Spinach

  class SpikeFeatureStepsParser

    # @param [String] content
    #   The content to parse.
    #
    # @api public
    def initialize(filename)
      @filename = filename
    end

    # USELESS!
    def self.open_file(filename)
      new filename
    end

    # Parses the feature file and returns a Feature.
    #
    # @return [Feature]
    #   The Feature.
    #
    # @api public
    def parse
      basename = File.basename(@filename, ".rb")
      step_definitions_class_name = class_name(basename)
      step_definitions_class = Spinach.find_step_definitions_class(step_definitions_class_name)
      step_definitions_class.spinach_feature
    end

    private

    def class_name(lower_case_and_underscored_word, first_letter_in_uppercase = true)
      if first_letter_in_uppercase
        lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
      else
        lower_case_and_underscored_word.to_s[0].chr.downcase + class_name(lower_case_and_underscored_word)[1..-1]
      end
    end
  end

end