require 'date'
require 'era_ja'

module Thinreports
  module Template
    module CLI
      class DateTime

        private_class_method :new
        def initialize(datetime)
          @datetime = datetime
        end

        def self.now
          new(::DateTime.now)
        end

        def self.parse(*args)
          new(::DateTime.parse(*args))
        end

        def strftime(format)
          @datetime.to_era(format)
        end

        def to_s
          @datetime.to_s
        end

      end
    end
  end
end
