
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

  var infowindow = new google.maps.InfoWindow();

  tweets.forEach(function(tweet) {
    if (tweet.latitude && tweet.longitude) {
      var marker = new google.maps.Marker({
        position: { lat: tweet.latitude, lng: tweet.longitude },
        map: map,
        title: tweet.title
      });

      marker.addListener('click', function() {
        infowindow.setContent("<h3><a>" +"Title:"+ tweet.title+ "<br>"+ "Body:"+tweet.body+"</a></h3>");
        infowindow.open(map, marker);
      });
    }
  });
}

$(window).mouseover(function() {
  $(".flash").delay(2000).fadeOut(300);
});

$("#signup").click(function () {
    $('.duck-sound')[0].currentTime = 0;
    return $('.duck-sound')[0].play();
});
