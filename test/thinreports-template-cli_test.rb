require 'test_helper'

class Thinreports::TemplateCLI::Test < Minitest::Test

  def test_version
    refute_nil Thinreports::TemplateCLI::VERSION
  end

  #  TODO
  # def test_json
  #   assert_output("std capture\n") {
  #     Thinreports::TemplateCLI::CLI.start(['test/fixtures/sample.tlf', '--format=json'])
  #   }
  # end

end
