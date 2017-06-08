require 'tty-table'
require 'csv'
require 'json'
require 'thinreports'
require 'thinreports/template-cli/datetime'

module Thinreports
  module TemplateCLI
    class Views

      def initialize(layout, format, params)
        @layout = layout
        @format = format
        @params = params
      end

      def render
        case @format
        when 'table'; to_table
        when 'csv'  ; to_csv
        when 'json' ; to_json
        when 'pdf'  ; to_pdf
        else to_table
        end
      end

      private

      def to_table
        table = TTY::Table.new(header:header, rows:rows)
        TTY::Table::Renderer::ASCII.new(table).render
      end

      def to_csv
        CSV.generate do |csv|
          csv << header
          rows.each do |row|
            csv << row.values
          end
        end
      end

      def to_json
        rows.to_json
      end

      def to_pdf
        report.generate
      end

      def header
        @header ||= %w(id ref_id display multiple default_value option_value real_value fmt_base fmt_type fmt_value desc)
      end

      def rows
        unless @rows
          @rows = []
          report.textblocks&.each do |shape|
            @rows << {
              'id' => shape.id,
              'ref_id' => shape.ref_id,
              'display' => shape.display?,
              'multiple' => shape.multiple?,
              'default_value' => shape.value,
              'option_value' => @params[shape.id].to_s,
              'real_value' => report.page.manager.shapes[shape.id.to_sym]&.internal&.real_value,
              'fmt_base' => shape.format_base,
              'fmt_type' => shape.format_type,
              'fmt_value' => shape.format_value,
              'desc' => shape.attributes['description']
            }
          end
        end
        return @rows
      end

      def report
        unless @report
          @report = Thinreports::Report.new(layout:@layout)
          @report.start_new_page
          @report.default_layout.format.shapes.values.each do |shape|
            case shape.type
            when Thinreports::Core::Shape::TextBlock::TYPE_NAME
              if shape.has_format?
                case shape.format_type
                when 'datetime'
                  if @params[shape.id]
                   @params[shape.id] = DateTime.parse(@params[shape.id])
                  else
                   @params[shape.id] = shape.value.empty? ? DateTime.now : DateTime.parse(shape.value)
                  end
                end
              end
            end
          end
          @report.page.values(@params)
        end
      return @report
      end

    end
  end
end
