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
    //   var infowindow = new google.maps.InfoWindow({
    //     content: "<h3><a>" + tweet.title + tweet.body+"</a></h3>"
    //   });

      var marker = new google.maps.Marker({
        position: { lat: tweet.latitude, lng: tweet.longitude },
        map: map,
        title: tweet.title
      });

      marker.addListener('click', function() {
          infowindow.setContent("<h3><a>" + tweet.title + tweet.body+"</a></h3>");
        infowindow.open(map, marker);
      });
    }
  });
}


  // var marker = [];
  // for(i=0; i<tweets.length;i++){
  //   var lat=tweets[i].latitude;
  //   console.log('rla',lat);
  //   var long=tweets[i].longitude;
  //   console.log('rlo',long);
  //   console.log('map', map);
  //   new google.maps.Marker({
  //     position: new google.maps.LatLng(lat,long),
  //     map: map,
  //     title: 'Hello !'
  //   });
  //   }
  // }

    // function createSidebarLi(tweet){
    //   return ("<li><a>" + tweet.title + tweet.body+"</a></li>");
    // }
    // function bindLiToMarker($li, marker){
    //   $li.on('click', function(){
    //     handler.getMap().setZoom(14);
    //     marker.setMap(handler.getMap()); //because clusterer removes map property from marker
    //     marker.panTo();
    //     google.maps.event.trigger(marker.getServiceObject(), 'click');
    //   });
    // }
    // function createSidebar(marker){
    //   _.each(marker, function(json){
    //     var $li = $( createSidebarLi(json) );
    //     $li.appendTo('#sidebar_container');
    //     bindLiToMarker($li, json.marker);
    //   });
    // }
    // _.each(marker, function(json, index){
    //   json.marker = marker[index];
    // });
    // createSidebar(marker);


    // { lat: 43, lng: 3.5},
    // { lat: 45, lng: 4},
    // { lat: 47, lng: 3.5},
    // { lat: 49, lng: 4},
    // { lat: 51, lng: 3.5}
