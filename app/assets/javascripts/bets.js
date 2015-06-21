// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {

  betsPage.init();


});

betsPage = {
  init: function() {
    betsPage.initStyling();
    betsPage.initEvents();

  },
  initStyling: function() {
    betsPage.styleStartTimes();
    betsPage.styleEndTimes();
    betsPage.styleTimeRemaining();
    betsPage.startDataTable();
  },
  initEvents: function() {
    $('body').on('click','.description', function() {
      betsPage.toggleActiveClass('description-mod')
    });
    $('body').on('click','.reward', function() {
      betsPage.toggleActiveClass('rewards-mod')
    });
    $('body').on('click','.entrants', function() {
      betsPage.toggleActiveClass('competitors-mod')
    });
  },
  timezoneSetter: function(timeValue) {
    return moment(timeValue).format("MMMM DD | hh:mm A");
  },
  durationSetter: function(timeValue) {
    return moment.duration(timeValue * 1000).humanize();
  },
  styleStartTimes: function() {
    var $startTimes = $('.start-time');
    $.each($startTimes, function(idx, val) {
      var newTime = betsPage.timezoneSetter($(val).html());
      $(val).html(newTime);
    });
  },
  styleEndTimes: function() {
    var $endTimes = $('.end-time');
    $.each($endTimes,function(idx, val) {
      var newTime = betsPage.timezoneSetter($(val).html());
      $(val).html(newTime);
    });
  },
  styleTimeRemaining: function() {
    var $timeRemaining = $('.time-remaining');
    $.each($timeRemaining, function(idx, val) {
      var newTime = betsPage.durationSetter($(val).html());
      $(val).html(newTime);
    });
  },
  startDataTable: function() {
    $('#lobby').DataTable({
      "scrollY": "400px",
      "scrollCollapse": true,
      "paging": false,
      "bInfo" : false,
      "bSort": false
    });
  },
  toggleActiveClass: function(klass) {
    $('.competitors-mod').removeClass('active');
    $('.description-mod ').removeClass('active')
    $('.rewards-mod').removeClass('active');
    if(klass === 'competitors-mod') {
      $('.competitors-mod').addClass('active');
    }
    if(klass === 'description-mod') {
      $('.description-mod').addClass('active');
    }
    if(klass === 'rewards-mod') {
      $('.rewards-mod').addClass('active');
    }
  }
}
