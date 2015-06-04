jQuery ->
  $container = $("#edit_profile_page")
  new EditCitizenProfile() if $($container).length

class EditCitizenProfile
  constructor: (@$container) ->
    @bindEvents()

  bindEvents: ->
    @updatePersonalInfo()

  updatePersonalInfo: ->
    $("#update_personal_info").click ->
      id = $(@).data("id")
      $.post "/citizens/#{id}/update_personal",
        data: "hey",
        -> swal "", "you did it!"

