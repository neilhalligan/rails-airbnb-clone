//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery-fileupload/basic
//= require cloudinary/jquery.cloudinary
//= require attachinary
//= require underscore
//= require gmaps/google
//= require bootstrap-datepicker
//= require jquery.slick
//= require_tree .

$(document).ready(function() {
  $(".datepicker").datepicker({
       autoclose: true,
    todayHighlight: true,
    format: 'dd/mm/yyyy'
  });

  $(".slickbox").slick({
    dots: true,
    infinite: true,
    speed: 500,
    fade: true,
    cssEase: 'linear'
  });
});
