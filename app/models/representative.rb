class Representative < Profile
  def full_name
    "#{first_name} #{last_name}"
  end
end
