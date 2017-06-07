require 'thinreports/template/cli/datetime'
require 'thinreports/template/cli/report'
require 'thinreports'
require 'terminal-table'
require 'yaml'

module Thinreports
  module Template
    module CLI
      class Actions

        def initialize(layout, options)
          @report = Thinreports::Report.new(layout:layout)
          @options = options
        end

        def generate
          @report.start_new_page
          @report.default_layout.format.shapes.values.each do |shape|
            case shape.type
            when Thinreports::Core::Shape::TextBlock::TYPE_NAME
              if shape.has_format?
                case shape.format_type
                when 'datetime'
                  if @options[shape.id]
                   @options[shape.id] = DateTime.parse(@options[shape.id])
                  else
                   @options[shape.id] = shape.value.empty? ? DateTime.now : DateTime.parse(shape.value)
                  end
                end
              end
            end
          end
          @report.page.values(@options)
          @report.generate
        end

        def info
          return Terminal::Table.new(title:@report.default_layout.format.report_title) do |table|
            textblocks = @report.default_layout.format.shapes.values.select{ |v|
              v.type == Thinreports::Core::Shape::TextBlock::TYPE_NAME
            }
            if !textblocks.empty?
              table << %w(id ref_id display? multiple? value format_base format_type format_value description)
              table << :separator
              textblocks.each do |s|
                format_value = ''
                format_value << s.format_datetime_format if s.format_datetime_format
                format_value << "delimiter=[#{s.format_number_delimiter}]" if s.format_number_delimiter
                format_value << "/precision=[#{s.format_number_precision}]" if s.format_number_precision
                table << [
                  s.id,
                  s.ref_id,
                  s.display?,
                  s.multiple?,
                  (@options[s.id] || s.value),
                  s.format_base,
                  s.format_type,
                  format_value,
                  s.attributes['description']
                ]
              end
            end
          end
        end

        def config
          @config2 = {}
          @report.default_layout.format.shapes.values.map do |shape|
            if shape.type ==  Thinreports::Core::Shape::TextBlock::TYPE_NAME
              @config2[shape.id] = (@params[shape.id] || shape.value)
            end
          end
          YAML.dump(@config2)
        end

      end
    end
  end
end
