require 'thinreports'
require 'thor'
require 'thinreports/template/cli/actions'

module Thinreports::Template::CLI::Utils
  refine Thinreports::Report::Base do
    def textblocks
      default_layout.format.shapes.values.select{ |s|
        s.type == Thinreports::Core::Shape::TextBlock::TYPE_NAME
      }
    end
  end
end
using Thinreports::Template::CLI::Utils

module Thinreports::Template::CLI::Base

  def build(argv=[])
    if layout = argv[1] && layout && FileTest.file?(layout)
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
    define_method(:info){ |style|
      puts Thinreports::Template::CLI::Actions.new(style, options.dup).info
    }
  end

  def define_generate_command(params)
    desc('generate TLF', 'Generate a PDF file from a TLF file')
    class_option(:config)
    params.each{ |param| method_option(param) }
    define_method(:generate){ |style|
      puts Thinreports::Template::CLI::Actions.new(style, options.dup).generate
    }
  end

  def define_config_command(params)
    desc('config TLF', 'Generate a config file from a TLF file')
    class_option(:config)
    params.each{ |param| method_option(param) }
    define_method(:config){ |style|
      puts Thinreports::Template::CLI::Actions.new(style, options.dup).config
    }
  end

end

class Thinreports::Template::CLI::Commands < Thor
  extend Thinreports::Template::CLI::Base
end
