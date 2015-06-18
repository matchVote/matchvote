jQuery ->
  $modal = $("#edit_privacy")
  new PrivacySettingsController($modal) if $modal.length

class PrivacySettingsController
  constructor: (@$modal) ->
    @$saveChangesButton = $("#save_privacy_settings_button")
    @updateSettings()

  updateSettings: ->
    self = @
    @$saveChangesButton.click ->
      $.post "/citizens/#{$(@).data("id")}/update_settings",
        user:
          settings:
            type: "privacy",
            display_all_stances: $("#display_all_stances").prop("checked"),
        ->
          swal "", "Privacy Settings Updated"
          self.$modal.modal "hide"

