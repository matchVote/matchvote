class RepresentativeOptions
  def demographic_options
    @demographic_options ||= DemographicOptions.new
  end

  def status_options
    { "In Office": :in_office, "Out Of Office": :out_of_office }
  end
end
