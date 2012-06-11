// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jqm-config
//= require jquery.mobile-1.0.1.min
//= require underscore
//= require backbone
//= require backbone_rails_sync
//= require backbone_datalink
//= require backbone.localStorage-min
//= require cookie
//= require backbone/asq_us
//= require_tree .


//Prevent scrolling
document.body.addEventListener('touchmove', function(event) {
  event.preventDefault();
}, false);
