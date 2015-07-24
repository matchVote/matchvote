class NavbarPresenter
  DROPDOWN_OPTIONS = [
    "news",
    "directory",
    "forum",
    "elections",
    "townhall",
    "stances"
  ]

  attr_reader :resource

  def initialize(resource)
    @resource = resource
  end

  def resource_formatted
    resource.capitalize
  end
end

