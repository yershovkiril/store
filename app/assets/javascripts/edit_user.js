$(document).ready(function() {
  var classErrorForm = $('.alert-error').parent().attr('class'),
  	margin = $('.alert-error').height() + 52 + 'px';
  if (classErrorForm == 'billing') {
  	$('form.shipping .first_name').parent().css('margin-top', margin)
  } else if (classErrorForm == 'shipping') {
  	$('form.billing .first_name').parent().css('margin-top', margin)
  }  
})
