require 'thinreports'

class Thinreports::Report::Base

  def textblocks
    default_layout.format.shapes.values.select{ |s|
      s.type == Thinreports::Core::Shape::TextBlock::TYPE_NAME
    }
  end

end

class Thinreports::Core::Shape::TextBlock::Format

  def format_value
    value = ''
    if format_datetime_format
      value << format_datetime_format
    end
    if format_number_delimiter
      value << "delimiter=[#{format_number_delimiter}]"
    end
    if format_number_precision
      value << "/precision=[#{format_number_precision}]"
    end
    return value
  end

end
