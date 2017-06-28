class Account < ActiveRecord::Base
  belongs_to :user

  def standard?
    account_type == "standard"
  end
end
