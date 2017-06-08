require 'optparse'
require 'thinreports'
require 'thinreports/template-cli/version'
require 'thinreports/template-cli/thinreports'
require 'thinreports/template-cli/views'

module Thinreports
  module TemplateCLI
    class CLI

      def self.start(argv)

        layout = nil
        format = nil
        params = {}

        options = OptionParser.new
        options.version = Thinreports::TemplateCLI::VERSION
        options.banner = "#{options.program_name} tlf [options]"
        options.separator('')
        options.separator('Basic Options')
        options.on('--format=table|csv|json|pdf') { |value|
          format = value
        }

        layout = argv.find{ |arg| FileTest.file?(arg) }
        if layout
          report = Thinreports::Report.new(layout:layout)
          options.separator('')
          options.separator('Thinreports Layout File Options')
          report.textblocks.each do |shape|
            options.on("--#{shape.id}=[#{shape.id.upcase}]", shape.attributes['description']) { |value|
              params[shape.id] = value
            }
          end
        end

        options.parse!(argv)
        puts Views.new(layout, format, params).render
      end

    end
  end
end
