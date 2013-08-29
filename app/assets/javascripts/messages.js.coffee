# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(->
  $('form').each ( ->
    $(this).on('submit', ->
      $(this).find('.hasDatepicker').each( -> 
        if $(this).val() != ''
          $(this).val(Date.parse($(this).val()).toISOString())
      )  
    ).on('ajax:success', ->
      $(this).find('.hasDatepicker').each( -> 
        try
          if $(this).val() != ''
            $(this).val(Date.parse($(this).val()).addHours(-(new Date().getTimezoneOffset()/60)).toString("MM/dd/yyyy hh:mm tt"))
        catch error
          $(this).val(Date.parseExact($(this).val(),'yyyy-MM-ddTHH:mm:ss.000Z').addHours(-(new Date().getTimezoneOffset()/60)).toString("MM/dd/yyyy hh:mm tt"))
      )
    )
  )
  
  $('.datetime').datetimepicker(
    ampm: true
    stepMinute: 1
    onClose: (dateText, inst) ->
      if $(this).attr('id') == 'message_send_at' && (new Date(dateText)) < Date.now()
        alert("Oops! You picked a date in the past.")
  )
)