
//= require foundation.min.js
//= require foundation
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require app
//= require what-input
//= require_tree .


Turbolinks.enableProgressBar();

$(window).mouseover(function() {
  $(".flash").delay(2000).fadeOut(300);
});
