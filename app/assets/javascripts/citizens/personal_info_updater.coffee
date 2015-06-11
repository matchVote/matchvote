jQuery ->
  $container = $("#citizen_personal_info")
  new PersonalInfoUpdater() if $($container).length

class PersonalInfoUpdater
  constructor: (@$container) ->
    @updatePersonalInfo()

  updatePersonalInfo: ->
    self = @
    $("#update_personal_info").click ->
      id = $(@).data("id")
      $.post "/citizens/#{id}/update_personal",
        self.collectInput(),
        -> swal "", "Personal Info Updated"

  collectInput: ->
    user:
      personal_info:
        first_name:   $("#first_name").val()
        last_name:    $("#last_name").val()
        birthday:     $("#date_picker").val()
        gender:       $("#gender").val()
        ethnicity:    $("#ethnicity").val()
        party:        $("#party").val()
        education:    $("#education").val()
        religion:     $("#religion").val()
        relationship: $("#relationship").val()
        bio:          $("#biography").val()

