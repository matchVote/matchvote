class RepProfileView
  include ActionView::Helpers

  def initialize(policy)
    @policy = policy
  end

  def edit_button
    render "edit_button" if @policy.update?
  end
end
