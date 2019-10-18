$(function(){
  //フォーム指定
  $('#registration').validate({
    errorClass: 'valid-err',
    //検証ルール設定
    rules: {
      "user[nickname]":{
        required: true
      },
      "user[email]":{
        required: true,
        email: true
      },
      "user[password]":{
        required: true,
        minlength: 6
      },
      "user[password_confirmaiton]":{
        required: true,
        minlength: 6,
        equalTo: "#user_password"
      },
      "user[family_name]":{
        required: true
      },
      "user[first_name]":{
        required: true
      },
      "user[family_kana_name]":{
        required: true
      },
      "user[first_kana_name]":{
        required: true
      },
      "user[birthday(1i)]":{
        required: true
      },
      "user[birthday(2i)]":{
        required: true
      },
      "user[birthday(3i)]":{
        required: true
      }
    },

    //エラーメッセージ設定
    messages: {
      "user[password]":{
        minlength:'６文字以上'
      },
      "user[password_confirmaiton]":{
        minlength:'６文字以上',
        equalTo: '入力した値が一致しません'
      }
    },

    //エラーメッセージ出力箇所設定
    errorPlacement: function(error, element){
      error.insertAfter(element);
    }
  });
});

$(function(){
  //フォーム指定
  $('#sms_confirmation').validate({
    errorClass: 'valid-err',
    //検証ルール設定
    rules: {
      "user[tel]":{
        required: true,
        number:true,
        rangelength: [11, 11]
      }
    },

    //エラーメッセージ設定
    messages: {
      "user[tel]":{
        required:'電話番号を入力してください',
        rangelength: '11文字で入力してください'
      }
    },

    //エラーメッセージ出力箇所設定
    errorPlacement: function(error, element){
      error.insertAfter(element);
    }
  });
});

$(function(){
  //フォーム指定
  $('#adress').validate({
    errorClass: 'valid-err',
    //検証ルール設定
    rules: {
      "user[adress_attributes][delivery_family_name]":{
        required: true
      },
      "user[adress_attributes][delivery_first_name]":{
        required: true
      },
      "user[adress_attributes][delivery_first_kana_name]":{
        required: true
      },
      "user[adress_attributes][delivery_family_kana_name]":{
        required: true
      },
      "user[adress_attributes][postal_code]":{
        required: true,
        rangelength:[7,7]
      },
      "user[adress_attributes][city]":{
        required:true
      },
      "user[adress_attributes][block]":{
        required:true
      }
    },

    //エラーメッセージ設定
    messages: {
      "user[adress_attributes][postal_code]":{
        required:'郵便番号を入力してください',
        rangelength: '7文字で入力してください'
      }
    },

    //エラーメッセージ出力箇所設定
    errorPlacement: function(error, element){
      error.insertAfter(element);
    }
  });
});

$(function(){
  $('#credit').validate({
    errorClass: 'valid-err',
    rules:{
      "user[credit_attributes][number]":{
        required:true,
        number:true,
        rangelength:[16,16]
      },
      "user[credit_attributes][expiration_date(1i)":{
        required: true
      },
      "user[credit_attributes][expiration_date(2i)":{
        required: true
      },
      "user[credit_attributes][security_code]":{
        required: true,
        rangelength:[3,4]
      }

    }
  })

})

