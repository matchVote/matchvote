class Representative < Profile
  def full_name
    "#{nickname_or_first_name.capitalize} #{last_name.capitalize}"
  end

  def profile_id
    "#{first_name}-#{last_name}"
  end

  def nickname_or_first_name
    nickname.blank? ? first_name : nickname
  end
end
