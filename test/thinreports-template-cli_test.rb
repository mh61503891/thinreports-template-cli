require 'test_helper'

class Thinreports::TemplateCLI::Test < Minitest::Test

  def test_version
    refute_nil Thinreports::TemplateCLI::VERSION
  end

  #  TODO
  def test_json
    assert_output('[{"id":"date","ref_id":"","display":true,"multiple":false,"default_value":"","option_value":"2017-01-01T00:00:00+00:00","real_value":"2017/01/01 00:00:00","fmt_base":"","fmt_type":"datetime","fmt_value":"%Y/%m/%d %H:%M:%S","desc":"This is a sample date."},{"id":"subject","ref_id":"","display":true,"multiple":false,"default_value":"","option_value":"","real_value":null,"fmt_base":"","fmt_type":"","fmt_value":"","desc":"This is a sample subject."},{"id":"name","ref_id":"","display":true,"multiple":false,"default_value":"","option_value":"","real_value":null,"fmt_base":"","fmt_type":"","fmt_value":"","desc":"This is a sample name."},{"id":"number","ref_id":"","display":true,"multiple":false,"default_value":"","option_value":"","real_value":null,"fmt_base":"","fmt_type":"number","fmt_value":"delimiter=[,]/precision=[0]","desc":"This is a sample number."},{"id":"date_jp","ref_id":"","display":true,"multiple":false,"default_value":"","option_value":"2017-01-01T00:00:00+00:00","real_value":"平成29年01月01日 00時00分00秒","fmt_base":"","fmt_type":"datetime","fmt_value":"%O%E年%m月%d日 %H時%M分%S秒","desc":"This is a sample date for Japanese era name."}]'+$/) {
      Thinreports::TemplateCLI::CLI.start(['test/fixtures/sample.tlf', '--format=json', "--date='2017-01-01'", "--date_jp='2017-01-01'"])
    }
  end

end
