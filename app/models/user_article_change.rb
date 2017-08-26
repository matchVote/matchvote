class UserArticleChange < ActiveRecord::Base
  def self.opposite_newsworthiness_type(type)
    {
      "increment" => "decrement",
      "decrement" => "increment",
    }[type]
  end
end
