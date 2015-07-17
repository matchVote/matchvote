$(document).on "page:change", ->
  $container = $("#profile_pic_upload")
  new UploadProfilePic($container) if $container.length

class UploadProfilePic
  constructor: (@$container) ->
    @bindEvents()

  bindEvents: ->
    @setClassOnFileSelection()
    @resetPic()

  setClassOnFileSelection: ->
    @$container.on "change.bs.fileinput", ->
      $(".fileinput-preview").children().first().addClass("edit_pic")

  resetPic: ->
    @$container.on "click", "#reset_profile_pic", ->
      $(".fileinput").fileinput("reset")

