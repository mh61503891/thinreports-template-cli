require 'thor'
require 'thinreports/template/cli/executor'

module Thinreports; module Template; module CLI; class Commands < Thor

  desc 'generate', 'Generate a PDF file from .tlf to stdout'
  option :layout, required:true
  option :config
  def generate
    print Thinreports::Template::CLI::Executor.new(get_report, get_config).generate
  end

  desc 'info', 'Display information for .tlf'
  option :layout, required:true
  option :config
  def info
    print Thinreports::Template::CLI::Executor.new(get_report, get_config).info
  end

  desc 'init', 'Create config file for .tlf'
  option :layout, required:true
  def init
    print Thinreports::Template::CLI::Executor.new(get_report).init
  end

  no_commands {

    def get_report
      return Thinreports::Report.new(layout:File.expand_path(options.layout))
    end

    def get_config
      options.config && YAML.load_file(options.config) || {}
    end

  }
end; end; end; end
