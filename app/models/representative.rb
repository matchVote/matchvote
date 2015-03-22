class Representative < Profile
  def full_name
    "#{nickname ? nickname : first_name} #{last_name}"
  end

  def profile_id
    "#{first_name}-#{last_name}"
  end

  def religion
    religion ? religion.capitalize : "N/A"
  end
end
