require 'thor'
require 'thinreports/template/cli/actions'

module Thinreports::Template::CLI::Base

  def build(argv)
    layout = argv[1]
    return unless layout && File.exists?(layout) && File.extname(layout) == '.tlf'
    define_commands(get_options(layout).values&.map(&:id))
  end

  def define_commands(params=[])
    define_info(params)
    define_generate(params)
    define_config(params)
  end

  private

  def define_command(name, usage, description, params, &block)
    desc(usage, description)
    class_option(:config)
    params.each{ |param| method_option(param) }
    define_method(name){ |report| yield(report) }
  end

  def define_info(params)
    define_command(:info, 'info TLF', 'Display info of a TLF file', params) { |report|
      puts get_executor(report, options).info
    }
  end

  def define_generate(params)
    define_command(:generate, 'generate TLF', 'Generate a PDF file from a TLF file', params) { |report|
      puts get_executor(report, options).generate
    }
  end

  def define_config(params)
    define_command(:config, 'config TLF', 'Generate a config file from a TLF file', params) { |report|
      puts get_executor(report, options).config
    }
  end

  def get_options(tlf)
    Thinreports::Report.new(layout:File.expand_path(tlf)).default_layout.format.shapes if tlf
  end

  def get_executor(report, options)
    Thinreports::Template::CLI::Actions.new(report, options.dup)
  end

end

class Thinreports::Template::CLI::Commands < Thor
  extend Thinreports::Template::CLI::Base
  define_commands()
end
