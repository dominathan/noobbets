// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {

  function timezoneSetter(timeValue) {
    return moment(timeValue).format("MMMM DD | hh:mm A")
  }

  var $startTimes = $('.start-time')
  var $endTimes = $('.end-time')

  $.each($startTimes, function(idx, val) {
    var newTime = timezoneSetter($(val).html())
    $(val).html("Start Time: " + newTime)
  });

  $.each($endTimes,function(idx, val) {
    var newTime = timezoneSetter($(val).html())
    $(val).html("End Time: " + newTime)
  });


});




