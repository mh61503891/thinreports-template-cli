require 'thor'
require 'thinreports/template-cli/commands'

module Thinreports
  module TemplateCLI
    class CLI  < Thor
      extend Commands
    end
  end
end
