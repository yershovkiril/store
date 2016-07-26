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
  
  useBiling();
});