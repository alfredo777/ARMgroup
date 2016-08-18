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
//= require turbolinks
//= require soundmanager2
//= require soundmanager2-jsmin
//= require soundmanager2-nodebug-jsmin
//= require soundmanager2-nodebug
//= require berniecode-animator
//= require player360
//= require handlebars
//= require hb-call
//= require routes-acces
//= require AJAXforms
//= require actions
//= require summernote
//= require jquery
//= require ahoy

$(document).ready(function(){
  $('a').click(function(){
    var hreF = $(this).attr('href');
    ahoy.track("Click", {title: "Click en -> "+hreF});
  });
});


