require 'thor'
require 'thinreports/template/cli/executor'

module Thinreports; module Template; module CLI; class Commands < Thor

  desc 'generate', 'Generate a PDF file from .tlf to stdout'
  option :layout, required:true
  option :config
  def generate
    puts Thinreports::Template::CLI::Executor.new(get_report, get_config).generate
  end

  desc 'info', 'Display information for .tlf'
  option :layout, required:true
  option :config
  def info
    puts Thinreports::Template::CLI::Executor.new(get_report, get_config).info
  end

  desc 'config', 'Create config file for .tlf'
  option :layout, required:true
  def config
    puts Thinreports::Template::CLI::Executor.new(get_report).config
  end

  no_commands {

    def get_report
      return Thinreports::Report.new(layout:File.expand_path(options.layout))
    end

    def get_config
      options.config && YAML.load_file(File.expand_path(options.config)) || {}
    end

  }
end; end; end; end
