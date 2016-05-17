

//= require jquery
//= require jquery_ujs
//= require foundation.min.js
//= require foundation
//= require turbolinks
//= require cloudinary
//= require app
//= require what-input
//= require_tree .


Turbolinks.enableProgressBar();

$(document).on('ready', function(e){
  $(window).mouseover(function() {
    $(".flash").delay(2000).fadeOut(300);
  });

  $("#signup").click(function () {
      $('.duck-sound')[0].currentTime = 0;
      return $('.duck-sound')[0].play();
  });

  $.ajax({
   method: "GET",
   url: "/tweets",
   success: getTweetsSuccess
  });

  function getTweetsSuccess(tweets) {
     this.tweets = tweets;
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
         infowindow.setContent("<h3><a>" +"Title:"+ tweet.title+ "<br>"+ "Body:"+tweet.body+"</a></h3>"+tweet.created_at);
           infowindow.open(map, marker);
         });
       }
     });
  }
})
