module Spinach
  # The hookable module includes subscription capabilities to the class in which
  # it is included.
  #
  # Take in account that while most subscription/notification mechanism work
  # at the class level, Hookable defines hooks at the instance level - so they
  # are not the same in all the class instances.
  module Hookable

    def self.included(base)
      base.class_eval do
        extend ClassMethods
        include InstanceMethods
      end
    end

    module ClassMethods
      # Adds a new hook to this class. Every hook defines two methods used to
      # add new callbacks and to run them passing a bunch of parameters.
      #
      # @example
      #   class
      def hook(hook)
        define_method hook do |&block|
          add_hook(hook, &block)
        end
        define_method "run_#{hook}" do |*args, &block|
          run_hook(hook, *args, &block)
        end
      end
    end

    module InstanceMethods
      attr_writer :hooks

      # @return [Hash]
      #   hash in which the key is the hook name and the value an array of any
      #   defined callbacks, or nil.
      def hooks
        @hooks ||= {}
      end

      # Resets all this class' hooks to a pristine state
      def reset
        self.hooks = {}
      end

      # Runs a particular hook given a set of arguments
      #
      # @param [String] name
      #   the hook's name
      #
      def run_hook(name, *args, &block)
        if callbacks = hooks[name.to_sym]
          callbacks.each{ |c| c.call(*args, &block) }
        else
          yield if block
        end
      end

      # @param [String] name
      #   the hook's identifier
      #
      # @return [Array]
      #   array of hooks for that particular identifier
      def hooks_for(name)
        hooks[name.to_sym] || []
      end

      # Adds a hook to the queue
      #
      # @param [String] name
      #   the hook's identifier
      #
      # @param [Proc] block
      #   an action to perform once that hook is executed
      def add_hook(name, &block)
        hooks[name.to_sym] ||= []
        hooks[name.to_sym] << block
      end
    end
  end
end
