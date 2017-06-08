require 'thinreports'
require 'thinreports/template-cli/thinreports'
require 'thinreports/template-cli/actions'

module Thinreports
  module TemplateCLI
    module Commands

      def build(argv=[])
        layout = argv[1]
        if layout && FileTest.file?(layout)
          params = Thinreports::Report.new(layout:layout).textblocks.map(&:id)
          define_commands(params)
        else
          define_commands()
        end
      end

      private

      def define_commands(params=[])
        define_info_command(params)
        define_generate_command(params)
        define_config_command(params)
      end

      def define_info_command(params)
        desc('info TLF', 'Display info of a TLF file')
        class_option(:config)
        params.each{ |param| method_option(param) }
        define_method(:info){ |layout|
          puts Actions.new(layout, options.dup).info
        }
      end

      def define_generate_command(params)
        desc('generate TLF', 'Generate a PDF file from a TLF file')
        class_option(:config)
        params.each{ |param| method_option(param) }
        define_method(:generate){ |layout|
          puts Actions.new(layout, options.dup).generate
        }
      end

      def define_config_command(params)
        desc('config TLF', 'Generate a config file from a TLF file')
        class_option(:config)
        params.each{ |param| method_option(param) }
        define_method(:config){ |layout|
          puts Actions.new(layout, options.dup).config
        }
      end

    end
  end
end
