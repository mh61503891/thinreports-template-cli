require 'thinreports'
require 'yaml'
require 'wareki'
require 'terminal-table'

module Thinreports; module Template; module CLI; class Executor

  def initialize(report, config=nil, options=nil)
    @report =  Thinreports::Report.new(layout:File.expand_path(report))
    @config = config
    @options = options
    $stderr.puts @options
  end

  def generate
    @report.start_new_page
    @report.default_layout.format.shapes.values.each do |shape|
      case shape.type
      when Thinreports::Core::Shape::TextBlock::TYPE_NAME
        if shape.has_format? && shape.format_type == 'datetime'
          @config[shape.id] ||= Date.today
        end
      else
      end
    end
    @report.page.values(@config)
    @report.generate
  end

  def info
    return Terminal::Table.new(title:@report.default_layout.format.report_title) do |t|
      textblocks = @report.default_layout.format.shapes.select{ |_, v|
        v.type == Thinreports::Core::Shape::TextBlock::TYPE_NAME
      }
      if !textblocks.empty?
        t << %w(id ref_id display? multiple? value format_base format_type format_value description)
        t << :separator
        textblocks.each_value do |s|
          format_value = ''
          format_value << s.format_datetime_format if s.format_datetime_format
          format_value << "delimiter=[#{s.format_number_delimiter}]" if s.format_number_delimiter
          format_value << "/precision=[#{s.format_number_precision}]" if s.format_number_precision
          t << [s.id, s.ref_id, s.display?, s.multiple?, (@config[s.id] || s.value), s.format_base, s.format_type, format_value, s.attributes['description']]
        end
      end
    end
  end

  def config
    @config2 = {}
    @report.default_layout.format.shapes.values.map do |shape|
      if shape.type ==  Thinreports::Core::Shape::TextBlock::TYPE_NAME
        @config2[shape.id] = (@config[shape.id] || shape.value)
      end
    end
    YAML.dump(@config2)
  end

end; end; end; end
