$.validator.addMethod("selectCheck", function(value, element,origin){
  return origin != value;
},"選択してください");

$(document).on('turbolinks:lood', function(){
  $('#').validate({
    errorClass: 'valid-err',
    rules:{

    },
    messages:{

    },
    errorPlacement: function(error, element){
      error.insertAfter(element);
    }
    
  });
});