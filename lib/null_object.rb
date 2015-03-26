class NullObject
  def self.nullify(object)
    object ? object : new
  end

  def initialize(default_value = "")
    @default_value = default_value
  end

  def method_missing(*args)
    @default_value
  end
end

