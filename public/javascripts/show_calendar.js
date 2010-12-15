$(document).ready(function() {

  jQuery.ajaxSetup({
    'beforeSend': function(xhr) { xhr.setRequestHeader("Accept", "text/javascript")}
  })
  
  jQuery(function ($) {
    $('#new_event').bind("ajax:success", eventCreated);
  });

  $('#new_event_div').dialog({autoOpen: false}); 

  $('li.my_calendars').click(function() {
    $('li.my_calendars > a').toggleClass("active");
    $('#calendars').toggle();
    return false;
  });

  $('#calendars').css('left', $('li.my_calendars').offset().left);
  $('#calendars').css('top', $('li.my_calendars').offset().top+18);

});

var format_string = "yyyy-MM-dd'T'HH:mm:ss";

function eventCreated(data, status, xhr) {
  $('#new_event_div').dialog('close');
  $('#new_event')[0].reset();
  $('#event_all_day').val("0");
  $('#calendar').fullCalendar('refetchEvents');
}

function dayClicked(dayDate, allDay, jsEvent, view) {
  $('#event_from').val($.fullCalendar.formatDate(dayDate, format_string));
  if (allDay) $('#event_all_day').val("1");
  $('#new_event_from').text($.fullCalendar.formatDate(dayDate, "u"))
  $('#new_event_div').dialog('option', 'position', [jsEvent.pageX, jsEvent.pageY]);
  $('#new_event_div').dialog('open');
}

function eventDropped(event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view) {
  updateEvent(event);
}

function eventResized(event, dayDelta, minuteDelta, revertFunc, jsEvent, ui, view) {
  updateEvent(event);
}

function updateEvent(event) {
  jQuery.post("/events/"+ event.id, {
    _method: "put",
    event: {
      from: $.fullCalendar.formatDate(event.start, format_string),
      to: $.fullCalendar.formatDate(event.end, format_string),
      all_day: event.allDay
    }
  });
}

function loadingIndicator(isLoading, view) {
  if (isLoading) {
    loadingSpan = $("<span class='loading_indicator'>loading...</span>");
    $(".fc-header-center").append(loadingSpan);
  } else {
    $(".loading_indicator").remove();
  }
}
