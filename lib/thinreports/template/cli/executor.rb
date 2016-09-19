require 'thinreports'
require 'yaml'
require 'wareki'
require 'kosi'

module Thinreports; module Template; module CLI; class Executor

  def initialize(report, config=nil)
    @report = report
    @config = config
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
    kosi = Kosi::Table.new({
      align: Kosi::Align::TYPE::LEFT,
      header: %w(b:id b:type b:display? bf:value tb:has_format? tb:format_type)
    })
    return kosi.render(@report.default_layout.format.shapes.values.map { |s|
      record = [s.id, s.type, s.display?, s.value]
      case s.type
      when Thinreports::Core::Shape::TextBlock::TYPE_NAME
        record += [s.has_format?, s.format_type]
      else
        record += [nil, nil]
      end
    })
  end

  def config
    @config = {}
    @report.default_layout.format.shapes.values.map do |shape|
      @config[shape.id] = shape.value
    end
    YAML.dump(@config)
  end

end; end; end; end
