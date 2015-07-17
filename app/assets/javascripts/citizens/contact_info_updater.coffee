$(document).on "page:change", ->
  $container = $("#citizen_contact_info")
  new ContactInfoUpdater() if $($container).length

class ContactInfoUpdater
  constructor: (@$container) ->
    @updateContactInfo()

  updateContactInfo: ->
    self = @
    $("#update_contact_info").click ->
      id = $(@).data("id")
      $.post "/citizens/#{id}/update_contact",
        self.collectInput(),
        -> swal "", "Contact Info Updated"

  collectInput: ->
    user:
      contact_attributes:
        id: $("#citizen_contact_info").data("id"),
        phone_numbers: [$("#phone_number").val()],
        external_ids:
          twitter_username: $("#twitter_username").val()
        postal_addresses_attributes:
          id: $("#citizen_postal_address").data("id"),
          line1: $("#line1").val()
          city: $("#city").val()
          state: $("#state").val()
          zip: $("#zip").val()

