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
//= require jquery.bxslider.min
//= require jquery.raty.min
//= require_tree .

$(document).ready(function(){
  function sliderInit() {
  	$('.bxslider').bxSlider({
		  auto: true,
		  pause: 5000
		});
  }
	
	sliderInit();
	
	$('ul.nav a').on('click', function(e) {
			if (e.target.innerText == 'HOME') {
				$('.bxslider').bxSlider({
				  auto: true,
				  pause: 5000
				});
			}		
	})
	
	var url = window.location.pathname;
  $('header ul.nav > li').removeClass('active');

  if (url.indexOf('/books') !== -1) {
    $('.shop').addClass('active');
  } else if (url.indexOf('/cart') !== -1) {
    $('.cart').addClass('active');
  } else if(url.indexOf('user/edit') !== -1) {
  	$('.settings').addClass('active');
  } else if(url.indexOf('users/sign_in') !== -1) {
  	$('.sign-in').addClass('active');
  } else if(url.indexOf('users/sign_up') !== -1) {
  	$('.sign-up').addClass('active');
  }	else if(url.indexOf('user') !== -1) {
  	$('.orders').addClass('active');
  } else if(url.indexOf('/') !== -1) {
  	$('.home').addClass('active');
  }
  
  $('.stars').raty({
      start:     1,
      path: '/assets'
  });
  
});