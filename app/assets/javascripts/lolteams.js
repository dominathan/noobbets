// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {

  lolteamsPage.init();


});

lolteamsPage = {
  init: function() {
    lolteamsPage.initStyling();
    lolteamsPage.initEvents();
  },
  initStyling: function() {

  },
  initEvents: function() {
    $('body').on('change','.form-control', function(event) {
      event.preventDefault();
      var idIWant  = $(this).attr('id'); //'lolteam_slot1'
      var slicedName = idIWant.slice(8)
      var summonerDBID = $("#"+idIWant+" option:selected").val();
      lolteamsPage.getSummonerInfo(summonerDBID,slicedName);//$("#"+slicedName+"-total-score"))
    })
  },
  getSummonerInfo: function(summonerID,slot_location) {
    $.ajax({
      method: "GET",
      url: "/summoners/" + summonerID + "/score",
      data: { },
      success: function(data) {
        lolteamsPage.appendToSpot(data,slot_location)
      },
      error: function(data) {
        return data
      }
    });
  },
  appendToSpot: function(what,where) {
    $("#"+where+"-total-score").html(what['total_score']);
    $("#"+where+"-champions-killed").html(what['champions_killed']);
    $("#"+where+"-deaths").html(what['num_deaths']);
    $("#"+where+"-assists").html(what['assists']);
  }
}
