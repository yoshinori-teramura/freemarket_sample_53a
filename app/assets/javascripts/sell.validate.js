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
        required: true
      },
      "item[description]":{
        required:true
      },
      "item[category_id]":{
        selectCheck: 0,
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
        required: true,
        number: true,
        rangelength:[1,7]
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
    messages:{
      "item[price]":{
        rangelength: '1千万未満で金額設定してください'
      }
    },
   
    errorPlacement: function(error, element){
      error.insertAfter(element);
    }   
  });
});

