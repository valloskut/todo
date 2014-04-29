# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  # to display an API key
  $('#reveal').hover ->
    $('#token').attr type: 'text'
  , ->
    $('#token').attr type: 'password'

  # to avoid issues with multiple datepickers
  $('html').on 'click', 'button.datepicker', (e) ->
    e.preventDefault()
    e.stopPropagation()
    $(this).parent().parent().find('input').focus().click()