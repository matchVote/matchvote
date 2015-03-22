class Representative < Profile
  def full_name
    "#{nickname ? nickname : first_name} #{last_name}"
  end

  def profile_id
    "#{nickname_or_first_name}-#{last_name}"
  end

  def nickname_or_first_name
    nickname ? nickname : first_name
  end
end
