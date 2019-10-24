$.validator.addMethod("selectCheck", function(value, element,origin){
  return origin != value;
  }, "選択してください。");

$(document).on('turbolinks:load', function () {

  $('#sellnewitem').validate({
    errorClass: 'valid-err',
    rules:{
      "item[image]":{
        required: true
      },
      "item[name]":{
        required: true,
        minlength : 5
      },
      "item[description]":{
        required:true
      },
      "item[category_id]":{
        selectCheck: 0,
        selectCheck: "--",
        required: true
      },
      "category_root_id":{
        selectCheck: 0
      },
      "category_child_id":{
        selectCheck: 0
      },
      "category_grandchild_id":{
        selectCheck: 0
      },
      "item[price]":{
        required: true
      },
      "item[item_status]":{
        selectCheck: 0

      },
      "item[shipping_charge]":{
        selectCheck: 0
      },
      "item[delivery_type]":{
        selectCheck: 0
      },
      "item[delivery_region]":{
        selectCheck: 0
      },
      "item[delivery_days]":{
        selectCheck: 0
      }
    },
   
    errorPlacement: function(error, element){
      error.insertAfter(element);
    }   
  });
});

