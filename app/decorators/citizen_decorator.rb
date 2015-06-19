class CitizenDecorator < SimpleDelegator
  def personal_info
    __getobj__.personal_info || {}
  end

  def first_name
    personal_info["first_name"]
  end

  def last_name
    personal_info["last_name"]
  end

  def bio
    personal_info["bio"]
  end

  def birthday
    personal_info["birthday"]
  end

  def party
    personal_info["party"]
  end

  def gender
    personal_info["gender"]
  end

  def relationship
    personal_info["relationship"]
  end

  def religion
    personal_info["religion"]
  end

  def education
    personal_info["education"]
  end

  def ethnicity
    personal_info["ethnicity"]
  end
end

