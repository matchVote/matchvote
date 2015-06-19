require "support/wait_for_ajax"

class Page
  include Capybara::DSL
  include Rails.application.routes.url_helpers
  include WaitForAjax
end

