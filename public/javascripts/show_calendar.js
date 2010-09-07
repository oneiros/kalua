$(document).ready(function() {

  jQuery.ajaxSetup({
    'beforeSend': function(xhr) { xhr.setRequestHeader("Accept", "text/javascript")}
  })
  
  jQuery(function ($) {
    $('#new_event').bind("ajax:success", eventCreated);
  });



  $('#new_event_div').dialog({autoOpen: false}); 

  $('#calendar').fullCalendar({
    events: "/events.json",
    header: {
      left: 'title',
      center: '',
      right: 'today agendaDay,agendaWeek,month prev,next'
    },
    defaultView: 'agendaWeek',
    height: $(window).height(),
    firstHour: 8,
    dayClick: dayClicked, 
    eventDrop: eventDropped,
    eventResize: eventResized
  })

});


function eventCreated(data, status, xhr) {
  $('#new_event_div').dialog('close');
  $('#new_event')[0].reset();
  $('#calendar').fullCalendar('refetchEvents');
}

function dayClicked(dayDate, allDay, jsEvent, view) {
  $('#event_from').val($.fullCalendar.formatDate(dayDate, "u"));
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
      from: $.fullCalendar.formatDate(event.start, "u"),
      to: $.fullCalendar.formatDate(event.end, "u"),
      all_day: event.allDay
    }
  });
}
