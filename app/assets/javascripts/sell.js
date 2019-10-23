$(document).on('turbolinks:load', function () {
  var SELECT_NONE = 0;
  var itemCategoryId = $('#item_category_id');

  // 読み込み時、非表示
  switchCategoryChildren(false);
  switchCategoryGrandchildren(false);
  // switchItemSize(false);
  switchDeliveryType(false);
  switchBrand(false);

  /**
   * 戻るボタン押下処理
   */
  $('#sell-back-btn').on('click', function (e) {
    e.preventDefault();
    window.history.back();
  });

  /**
   * 価格入力処理
   */
  $('#sell_input_price').on('keyup', function (e) {
    var input = this.value;

    if (input.length === 0 || isNaN(input)) {
      resetSellPrice();
      return false;
    }

    if (input < 300 || 9999999 < input) {
      resetSellPrice();
      return false;
    }

    var price = Number(input);
    var tax = Math.round(price / 10);
    var profit = price - tax;

    // 販売手数料
    $(".sell-form-price__tax--right").text('¥' + tax.toLocaleString());
    // 販売利益
    $(".sell-form-price__profit--right").text('¥' + profit.toLocaleString());
  });

  /**
   * 価格表示をリセット
   */
  function resetSellPrice() {
    // 販売手数料
    $(".sell-form-price__tax--right").text("-");
    // 販売利益
    $(".sell-form-price__profit--right").text("-");
  }

  /**
   * カテゴリ選択処理
   */
  $('#category_root_id').on('change', function (e) {
    var selectedValue = $(this).val()
    itemCategoryId.val(selectedValue);

    if (selectedValue == SELECT_NONE) {
      // 子カテゴリ
      switchCategoryChildren(false);
      // 孫カテゴリ
      switchCategoryGrandchildren(false);
      // // サイズ
      // resetOptions('#item_size');
      return;
    }

    // 子カテゴリ
    switchCategoryChildren(true, selectedValue);

    // 孫カテゴリ
    switchCategoryGrandchildren(false);

    // // サイズ
    // resetOptions('#item_size');
    // switchItemSize(false);
  });


  /**
   * 子カテゴリ選択処理
   */
  $('#category_child_id').on('change', function (e) {
    var selectedValue = $(this).val()
    itemCategoryId.val(selectedValue);

    if (selectedValue == SELECT_NONE) {
      // 孫カテゴリ
      switchCategoryGrandchildren(false);
      // // サイズ
      // resetOptions('#item_size');
      return;
    }

    // 孫カテゴリ
    switchCategoryGrandchildren(true, selectedValue);

    // // サイズ: 子カテゴリと紐づく
    // var item_sizes = [{"id": "2", "name": "S"}];
    // resetOptions('#item_size', item_sizes);
    // switchItemSize(false);
  });


  /**
   * 孫カテゴリ選択処理
   */
  $('#category_grandchild_id').on('change', function (e) {
    var selectedValue = $(this).val()
    itemCategoryId.val(selectedValue);

    if (selectedValue == SELECT_NONE) {
      return;
    }

    // // サイズ
    // switchItemSize(true);

    // ブランド
    switchBrand(true);
  });

  /**
   * 配送料の負担選択処理
   */
  $('#shipping_charge').on('change', function (e) {
    var selectedValue = $(this).val();
    if (selectedValue == SELECT_NONE) {
      resetOptions('#delivery_type');
      switchDeliveryType(false);
      return;
    }

    $.ajax({
      url: 'sell/get_delivery_types',
      type: 'GET',
      data: { shipping_charge_id: selectedValue },
      dataType: 'json'
    })
    .done(function(types){
      resetOptions('#delivery_type', types);
      switchDeliveryType(true);
    })
    .fail(function(){
      console.log('delivery_type not found');
      resetOptions('#delivery_type');
      switchDeliveryType(false);
    })
  });

  /**
   * セレクトボックスの内容を再設定する
   * @param {String} selector セレクトボックスのId
   * @param {Array} values セットする連想配列 {id, name}
   */
  function resetOptions(selector, values = null) {
    $(selector + ' > option').remove();
    // 選択なし
    $(selector).append($('<option>').html('---').val(SELECT_NONE));
    if (values !== null) {
      values.forEach(function (val) {
        $(selector).append($('<option>').html(val.name).val(val.id));
      });
    }
  }

  /**
   * 子カテゴリの表示を切り替える
   * @param {Boolean} isVisible 表示するか
   * @param {Number} category_id カテゴリ
   */
  function switchCategoryChildren(isVisible, category_id = 0) {
    if (isVisible) {
      if (category_id === 0) {
        resetOptions('#category_child_id');
        $('#category_child_id').parents('.sell-form-selectbox__select-wrapper').show();
        return;
      }

      getCategoriesAsync(category_id)
      .done(function(categories){
        resetOptions('#category_child_id', categories);
        $('#category_child_id').parents('.sell-form-selectbox__select-wrapper').show();
      })
      .fail(function(){
        console.log('category not found');
        resetOptions('#category_child_id');
        $('#category_child_id').parents('.sell-form-selectbox__select-wrapper').hide();
      })

    } else {
      resetOptions('#category_child_id');
      $('#category_child_id').parents('.sell-form-selectbox__select-wrapper').hide();
    }
  }

  /**
   * 孫カテゴリの表示を切り替える
   * @param {Boolean} isVisible 表示するか
   * @param {Number}  category_id 子カテゴリ
   */
  function switchCategoryGrandchildren(isVisible, category_id = 0) {
    if (isVisible) {
      if (category_id === 0) {
        resetOptions('#category_grandchild_id');
        $('#category_grandchild_id').parents('.sell-form-selectbox__select-wrapper').show();
        return;
      }

      getCategoriesAsync(category_id)
      .done(function(categories){
        resetOptions('#category_grandchild_id', categories);
        $('#category_grandchild_id').parents('.sell-form-selectbox__select-wrapper').show();
      })
      .fail(function(){
        console.log('category not found');
        resetOptions('#category_grandchild_id');
        $('#category_grandchild_id').parents('.sell-form-selectbox__select-wrapper').hide();
      })

    } else {
      resetOptions('#category_grandchild_id');
      $('#category_grandchild_id').parents('.sell-form-selectbox__select-wrapper').hide();
    }
  }

  /**
   * 子孫カテゴリを非同期で取得
   * @param {Number} category_id カテゴリID
   */
  function getCategoriesAsync(category_id) {
    return  $.ajax({
      url: '/sell/get_category_children',
      type: 'GET',
      data: { category_id: category_id },
      dataType: 'json'
    })
  }

  /**
   * サイズの表示を切り替える
   * @param {Boolean} isVisible 表示するか
   */
  function switchItemSize(isVisible) {
    if (isVisible) {
      $('#item_size').parents('.sell-form-selectbox').show();
    } else {
      $('#item_size').parents('.sell-form-selectbox').hide();
    }
  }

  /**
   * 配送の方法の表示を切り替える
   * @param {Boolean} isVisible 表示するか
   */
  function switchDeliveryType(isVisible) {
    if (isVisible) {
      $('#delivery_type').parents('.sell-form-selectbox').show();
    } else {
      $('#delivery_type').parents('.sell-form-selectbox').hide();
    }
  }

  /**
   * ブランドの表示を切り替える
   * @param {Boolean} isVisible 表示するか
   */
  function switchBrand(isVisible) {
    if (isVisible) {
      $('#brand_name').parents('.sell-form-text').show();
    } else {
      $('#brand_name').parents('.sell-form-text').hide();
    }
  }

});