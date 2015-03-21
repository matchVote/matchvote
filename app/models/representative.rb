class Representative < Profile
  def full_name
    "#{first_name} #{last_name}"
  end

  def rep_id
    "#{first_name}-#{last_name}"
  end
end
