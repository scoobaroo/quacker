// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation.min.js
//= require foundation
//= require underscore
//= require gmaps/google
//= require turbolinks
//= require app
//= require what-input
//= require_tree .
Turbolinks.enableProgressBar();
var handler = Gmaps.build('Google');
$.ajax({
  method: "GET",
  url: "/tweets",
  success: getTweetsSuccess
});
function getTweetsSucess(tweets) {
  handler.buildMap({internal:{id:'multi_markers'}}, function(){
    for(i=0; i<tweets.length;i++){
    var markers = handler.addMarker(
      {lat:tweets[i].latitude, lng:tweets[i].longitude}
    );
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
    }
  }
);}
handler.buildMap({ internal: {id: 'multi_markers'}}, function(){
  var markers = handler.addMarkers([
    { lat: 43, lng: 3.5},
    { lat: 45, lng: 4},
    { lat: 47, lng: 3.5},
    { lat: 49, lng: 4},
    { lat: 51, lng: 3.5}
  ]);
  handler.bounds.extendWith(markers);
  handler.fitMapToBounds();
});
