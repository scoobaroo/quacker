
//= require foundation.min.js
//= require foundation
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require cloudinary
//= require app
//= require what-input
//= require_tree .


Turbolinks.enableProgressBar();

$(window).mouseover(function() {
  $(".flash").delay(2000).fadeOut(300);
});

$("#signup").click(function () {
    $('.duck-sound')[0].currentTime = 0;
    return $('.duck-sound')[0].play();
});
