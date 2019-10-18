$(document).on('turbolinks:load', function () {
  var SELECT_NONE = '---';

  // 読み込み時、非表示
  switchCategoryChildren(false);
  switchCategoryGrandchildren(false);
  switchItemSize(false);
  switchDeliveryType(false);

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
  $('#category_id').on('change', function (e) {

    if ($(this).val() === SELECT_NONE) {
      // 子カテゴリ
      switchCategoryChildren(false);
      // 孫カテゴリ
      switchCategoryGrandchildren(false);
      // サイズ
      resetOptions('#item_size');
      return;
    }

    // 子カテゴリ
    switchCategoryChildren(true);

    // 孫カテゴリ
    switchCategoryGrandchildren(false);

    // サイズ
    resetOptions('#item_size');
    switchItemSize(false);
  });


  /**
   * 子カテゴリ選択処理
   */
  $('#category_child_id').on('change', function (e) {

    if ($(this).val() === SELECT_NONE) {
      // 孫カテゴリ
      switchCategoryGrandchildren(false);
      // サイズ
      resetOptions('#item_size');
      return;
    }

    // 孫カテゴリ
    switchCategoryGrandchildren(true);

    // サイズ: 子カテゴリと紐づく
    var item_sizes = [{
        "id": "2",
        "name": "S"
      },
      {
        "id": "3",
        "name": "M"
      },
      {
        "id": "4",
        "name": "L"
      }
    ];
    resetOptions('#item_size', item_sizes); //値を設定するのみ
    switchItemSize(false);
  });


  /**
   * 孫カテゴリ選択処理
   */
  $('#category_grandchild_id').on('change', function (e) {

    if ($(this).val() === SELECT_NONE) {
      return;
    }

    // サイズ
    switchItemSize(true);
  });

  /**
   * 配送料の負担選択処理
   */
  $('#pay_delivery_fee').on('change', function (e) {

    if ($(this).val() === SELECT_NONE) {
      resetOptions('delivery_type');
      switchDeliveryType(false);
      return;
    }

    // TODO: 送料込みか着払いかで値が変わるようにする
    var values = [{
        "id": "5",
        "name": "未定"
      },
      {
        "id": "6",
        "name": "レターパック"
      },
      {
        "id": "7",
        "name": "ゆうメール"
      }
    ];
    resetOptions('delivery_type', values);
    switchDeliveryType(true);
  });

  /**
   * セレクトボックスの内容を再設定する
   * @param {String} selector セレクトボックスのId
   * @param {Array} values セットする連想配列 {id, name}
   */
  function resetOptions(selector, values = null) {
    $(selector + ' > option').remove();
    $(selector).append($('<option>').html(SELECT_NONE).val(SELECT_NONE));
    if (values !== null) {
      values.forEach(function (val) {
        $(selector).append($('<option>').html(val.name).val(val.id));
      });
    }
  }

  /**
   * 子カテゴリの表示を切り替える
   * @param {Boolean} isVisible 表示するか
   */
  function switchCategoryChildren(isVisible) {
    if (isVisible) {
      // TODO:非同期で子カテゴリの値を取得する
      var values = [{
          "id": "30",
          "name": "トップス"
        },
        {
          "id": "31",
          "name": "ジャケット/アウター"
        },
        {
          "id": "32",
          "name": "パンツ"
        }
      ];
      resetOptions('#category_child_id', values);
      $('#category_child_id').parents('.sell-form-selectbox__select-wrapper').show();
    } else {
      resetOptions('#category_child_id');
      $('#category_child_id').parents('.sell-form-selectbox__select-wrapper').hide();
    }
  }

  /**
   * 孫カテゴリの表示を切り替える
   * @param {Boolean} isVisible 表示するか
   */
  function switchCategoryGrandchildren(isVisible) {
    if (isVisible) {
      // TODO:非同期で孫カテゴリの値を取得する
      var values = [{
          "id": "302",
          "name": "Tシャツ/カットソー"
        },
        {
          "id": "304",
          "name": "シャツ"
        },
        {
          "id": "305",
          "name": "ポロシャツ"
        }
      ];
      resetOptions('#category_grandchild_id', values);
      $('#category_grandchild_id').parents('.sell-form-selectbox__select-wrapper').show();
    } else {
      resetOptions('#category_grandchild_id');
      $('#category_grandchild_id').parents('.sell-form-selectbox__select-wrapper').hide();
    }
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

});