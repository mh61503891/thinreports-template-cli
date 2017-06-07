require 'thinreports'

class Thinreports::Report::Base
  def textblocks
    default_layout.format.shapes.values.select{ |s|
      s.type == Thinreports::Core::Shape::TextBlock::TYPE_NAME
    }
  end
end
