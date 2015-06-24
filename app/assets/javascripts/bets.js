// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {

  betsPage.init();
  showBetPage.init();

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

showBetPage = {
  init: function() {
    showBetPage.initEvents();
    showBetPage.initStyling();
  },
  initEvents: function() {
    $('.show-lolteam').on('click', function(event) {
      event.preventDefault;
      $('.hidden').removeClass('hidden');
      $('.show-me').remove()
      showBetPage.getUserLolteam(this.value,this.text);
    })
  },
  initStyling: function() {
    $('.hidden').css("display: none");
  },
  getUserLolteam: function(lolteamId,userName){
    var myURL = window.location.href.split("/");
    var betId = myURL[myURL.length - 3];
    $.ajax({
      method: "GET",
      url: "/bets/" + betId + "/lolteams/" + lolteamId + "/score",
      success: function(data) {
        return showBetPage.appendLolteamData(data,userName);
      },
      error: function(data) {
        return data;
      },
    });
  },
  appendLolteamData: function(data,userName) {
    $('#name1').text(data['name1']);
    $('#name2').text(data['name2']);
    $('#name3').text(data['name3']);
    $('#name4').text(data['name4']);
    $('#name5').text(data['name5']);
    $('#name6').text(data['name6']);
    $('#name7').text(data['name7']);
    $('#slot1').text(data['slot1']);
    $('#slot2').text(data['slot2']);
    $('#slot3').text(data['slot3']);
    $('#slot4').text(data['slot4']);
    $('#slot5').text(data['slot5']);
    $('#slot6').text(data['slot6']);
    $('#slot7').text(data['slot7']);
    $('#new-username').text(userName);
    $('#total-score-for-user').text(data['total-score']);
  }
}
