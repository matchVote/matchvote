jQuery ->
  $container = $("#citizen_contact_info")
  new ContactInfoUpdater() if $($container).length

class ContactInfoUpdater
  constructor: (@$container) ->
    @updateContactInfo()

  updateContactInfo: ->
    self = @
    $("#update_contact_info").click ->
      id = $(@).data("id")
      $.post "/citizens/#{id}/update_citizen_info",
        self.collectInput(),
        -> swal "", "Contact Info Updated"

  collectInput: ->
    user:
      contact_attributes:
        phone_numbers: [$("#phone_number").val()]

