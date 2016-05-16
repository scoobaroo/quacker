
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
//

$.ajax({
  method: "GET",
  url: "/tweets",
  success: getTweetsSuccess
});

function getTweetsSuccess(tweets) {
  var myLatLng = {lat: 37.78, lng: -122.44};
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom:2,
    center: myLatLng
  });

  for (var i = 0; i < tweets.length; i++) {
    if (tweets[i].latitude && tweets[i].longitude) {
      var infowindow = new google.maps.InfoWindow({
        content: "<h3><a>" + tweets[i].title + tweets[i].body+"</a></h3>"
      });

      var marker = new google.maps.Marker({
        position: { lat: tweets[i].latitude, lng: tweets[i].longitude },
        map: map,
        title: tweets[i].title
      });

      marker.addListener('click', function() {
        infowindow.open(map, marker);
      });
    }
  }
}

$(window).mouseover(function() {
  $(".flash").delay(2000).fadeOut(300);
});

$("#signup").click(function () {
    $('.duck-sound')[0].currentTime = 0;
    return $('.duck-sound')[0].play();
});
