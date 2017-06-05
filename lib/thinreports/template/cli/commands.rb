require 'thor'
require 'thinreports/template/cli/actions'

module Thinreports::Template::CLI::DSL

  def define_options(usage, description, params)
    desc(usage, description)
    class_option(:config)
    params.each{ |param| method_option(param) }
  end

end

module Thinreports::Template::CLI::Base

  include Thinreports::Template::CLI::DSL

  def build(argv={})
    layout = argv[1]
    if layout && File.exists?(layout) && File.extname(layout) == '.tlf'
      params = Thinreports::Report.new(layout:File.expand_path(layout)).default_layout.format.shapes.values.map(&:id)
      define_commands(params)
    else
      define_commands()
    end
  end

  def define_commands(params=[])
    define_info(params)
    define_generate(params)
    define_config(params)
  end

  def define_info(params)
    define_options('info TLF', 'Display info of a TLF file', params)
    define_method(:info){ |report|
      puts Thinreports::Template::CLI::Actions.new(report, options.dup).info
    }
  end

  def define_generate(params)
    define_options('generate TLF', 'Generate a PDF file from a TLF file', params)
    define_method(:generate){ |report|
      puts Thinreports::Template::CLI::Actions.new(report, options.dup).generate
    }
  end

  def define_config(params)
    define_options('config TLF', 'Generate a config file from a TLF file', params)
    define_method(:config){ |report|
      puts Thinreports::Template::CLI::Actions.new(report, options.dup).config
    }
  end

end

class Thinreports::Template::CLI::Commands < Thor
  extend Thinreports::Template::CLI::Base
end
