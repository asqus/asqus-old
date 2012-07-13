// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery_ujs
//= require jquery-ui
//= require jqm-config
//= require underscore
//= require backbone
//= require backbone_rails_sync
//= require backbone_datalink
//= require backbone.localStorage-min
//= require cookie
//= require backbone/asq_us
//= require_tree .


$(function() {
  
  //Prevent scrolling
  document.body.addEventListener('touchmove', function(event) {
    event.preventDefault();
  }, false);

  $('#navbar').scrollspy({offset: '0px'});
  $.localScroll({
    axis: 'y',
    //offset: {
    //  top: '100px'
    //},
    offset: -50,
    duration: 500
  });

  emailSignupListener();
  
});


function emailSignupListener() {
  $('form.email_signup').on('submit', function(event) {
    console.log(event.target);
    var container = $(event.target.parentElement)
    container.children('form').hide()
    container.children('.loader').show()
    $.ajax({
      type: 'POST',
      url: '/users/email_signup',
      data: container.children('form').serialize(),
      success: function() {
        container.children('.loader').hide()
        container.children('.success').show()
      },
      error: function() {
        container.children('.loader').hide()
        container.children('form').show()
      }
    });
    return false
  });
}




