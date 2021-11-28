require "date"

class Visitor
  attr_accessor :name

  def initialize(attrs = {})
    @name = set_name(attrs[:name])
  end

  private

  def set_name(name)
    name == nil ? missing_name : name
  end

  def missing_name
    raise RuntimeError, "A name is required"
  end
end
