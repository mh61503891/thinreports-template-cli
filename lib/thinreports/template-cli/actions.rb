require 'thinreports/template-cli/datetime'
require 'thinreports/template-cli/thinreports'
require 'thinreports'
require 'tty-table'
require 'yaml'

module Thinreports
  module TemplateCLI
    class Actions

      def initialize(layout, options)
        @report = Thinreports::Report.new(layout:layout)
        @options = options
      end

      def generate
        create && @report.generate
      end

      def info
        create
        header = %w(id ref_id disp? multi default_value option_value real_value fmt_base fmt_type fmt_value desc)
        table = TTY::Table.new(header:header)
        @report.textblocks&.each.with_index do |shape, index|
          table << [
            shape.id,
            shape.ref_id,
            shape.display?,
            shape.multiple?,
            shape.value,
            @options[shape.id].to_s,
            @report.page.manager.shapes[shape.id.to_sym]&.internal&.real_value,
            shape.format_base,
            shape.format_type,
            shape.format_value,
            shape.attributes['description']
          ]
        end
        TTY::Table::Renderer::ASCII.new(table).render
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

      private

      def create
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
      end

    end
  end
end
