class NullObject
  def self.nullify(object, default_value = "")
    object ? object : new(default_value)
  end

  def initialize(default_value = "")
    @default_value = default_value
  end

  def method_missing(*args)
    @default_value
  end
end

