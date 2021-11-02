$(document).ready(function() {
  var addressCheckbox = $("input#checkout_form_use_billing");
  
  function useBiling() {
    if (addressCheckbox.is(':checked')) {
      $("#shipping").hide();
    } else {
      $("#shipping").show();
    }
  }
  
  addressCheckbox.on('click', function() {
    useBiling();
  });
  
  function getCookie(name) {
    var matches = document.cookie.match(new RegExp(
      "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
    ));
    return matches ? decodeURIComponent(matches[1]) : undefined;
  }
  
  function setCookie(name, value, options) {
    options = options || {};
  
    var expires = options.expires;
  
    if (typeof expires == "number" && expires) {
      var d = new Date();
      d.setTime(d.getTime() + expires * 1000);
      expires = options.expires = d;
    }
    if (expires && expires.toUTCString) {
      options.expires = expires.toUTCString();
    }
  
    value = encodeURIComponent(value);
  
    var updatedCookie = name + "=" + value;
  
    for (var propName in options) {
      updatedCookie += "; " + propName;
      var propValue = options[propName];
      if (propValue !== true) {
        updatedCookie += "=" + propValue;
      }
    }
  
    document.cookie = updatedCookie;
  }
  
  
  if (getCookie("useBilling") == 'false') {
  	$("input#checkout_form_use_billing").prop( "checked", false)
  } else {
  	$("input#checkout_form_use_billing").prop( "checked")	
  } 
  
  $('#checkout_form_use_billing').on('click', function(event) {
  	setCookie("useBilling", event.currentTarget.checked);
  })
  
  var url = window.location.pathname;
  if (url.indexOf('/complete') !== -1) {
  	setCookie("useBilling", 'true');
  }
  
  useBiling();
  
  var classErrorForm = $('.alert-error').parent().attr('class'),
  	margin = $('.alert-error').height();
  if (classErrorForm == 'col-md-6 billing') {
  	$('.shipping .first_name').parent().css('margin-top', margin + 32 + 'px')
  } else if (classErrorForm == 'col-md-6 shipping') {
  	$('.billing .first_name').parent().css('margin-top', margin + 78 + 'px')
  }  
  
});