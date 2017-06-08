$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'thinreports/template-cli'
require 'minitest/reporters'
Minitest::Reporters.use!
require 'minitest/autorun'
