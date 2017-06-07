require 'date'
require 'era_ja'

class String
  def strftime(format)
    DateTime.parse(self).to_era(format)
  end
end
