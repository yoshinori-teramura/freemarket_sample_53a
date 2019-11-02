$(document).on('turbolinks:load', function () {
  var SELECT_NONE = 0;
  var CATEGORY_ROOT_SELECTOR = '#category_root_id';
  var CATEGORY_CHILD_SELECTOR = '#category_child_id';
  var CATEGORY_GRANDCHILD_SELECTOR = '#category_grandchild_id';
  var SHIPPING_CHARGE_SELECTOR = '#shipping_charge';
  var SELL_PRICE_SELECTOR = '#sell_input_price';
  var itemCategoryId = $('#item_category_id');

  // ロード時
  if ($(CATEGORY_CHILD_SELECTOR).val() == SELECT_NONE) {
    switchCategoryChildren(false);
  }

  if ($(CATEGORY_GRANDCHILD_SELECTOR).val() == SELECT_NONE) {
    switchCategoryGrandchildren(false);
  }

  // switchItemSize(false);

  if ($(SHIPPING_CHARGE_SELECTOR).val() == SELECT_NONE) {
    switchDeliveryType(false);
  }

  if ($(SELL_PRICE_SELECTOR).val()) {
    calcSellPrice($(SELL_PRICE_SELECTOR).val());
  }

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
  $(SELL_PRICE_SELECTOR).on('keyup', function (e) {
    calcSellPrice(this.value)
  });

  /**
   * 計算した価格を表示
   * @param {String} input 入力値
   */
  function calcSellPrice(input) {
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
  }

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
  $(CATEGORY_ROOT_SELECTOR).on('change', function (e) {
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
  $(CATEGORY_CHILD_SELECTOR).on('change', function (e) {
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
  $(CATEGORY_GRANDCHILD_SELECTOR).on('change', function (e) {
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
  $(SHIPPING_CHARGE_SELECTOR).on('change', function (e) {
    var selectedValue = $(this).val();
    if (selectedValue == SELECT_NONE) {
      resetOptions('#delivery_type');
      switchDeliveryType(false);
      return;
    }

    $.ajax({
        url: '/sell/get_delivery_types',
        type: 'GET',
        data: {
          shipping_charge_id: selectedValue
        },
        dataType: 'json'
      })
      .done(function (types) {
        resetOptions('#delivery_type', types);
        switchDeliveryType(true);
      })
      .fail(function () {
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
        resetOptions(CATEGORY_CHILD_SELECTOR);
        $(CATEGORY_CHILD_SELECTOR).parents('.sell-form-selectbox__select-wrapper').show();
        return;
      }

      getCategoriesAsync(category_id)
        .done(function (categories) {
          resetOptions(CATEGORY_CHILD_SELECTOR, categories);
          $(CATEGORY_CHILD_SELECTOR).parents('.sell-form-selectbox__select-wrapper').show();
        })
        .fail(function () {
          console.log('category not found');
          resetOptions(CATEGORY_CHILD_SELECTOR);
          $(CATEGORY_CHILD_SELECTOR).parents('.sell-form-selectbox__select-wrapper').hide();
        })

    } else {
      resetOptions(CATEGORY_CHILD_SELECTOR);
      $(CATEGORY_CHILD_SELECTOR).parents('.sell-form-selectbox__select-wrapper').hide();
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
        resetOptions(CATEGORY_GRANDCHILD_SELECTOR);
        $(CATEGORY_GRANDCHILD_SELECTOR).parents('.sell-form-selectbox__select-wrapper').show();
        return;
      }

      getCategoriesAsync(category_id)
        .done(function (categories) {
          resetOptions(CATEGORY_GRANDCHILD_SELECTOR, categories);
          $(CATEGORY_GRANDCHILD_SELECTOR).parents('.sell-form-selectbox__select-wrapper').show();
        })
        .fail(function () {
          console.log('category not found');
          resetOptions(CATEGORY_GRANDCHILD_SELECTOR);
          $(CATEGORY_GRANDCHILD_SELECTOR).parents('.sell-form-selectbox__select-wrapper').hide();
        })

    } else {
      resetOptions(CATEGORY_GRANDCHILD_SELECTOR);
      $(CATEGORY_GRANDCHILD_SELECTOR).parents('.sell-form-selectbox__select-wrapper').hide();
    }
  }

  /**
   * 子孫カテゴリを非同期で取得
   * @param {Number} category_id カテゴリID
   */
  function getCategoriesAsync(category_id) {
    return $.ajax({
      url: '/sell/get_category_children',
      type: 'GET',
      data: {
        category_id: category_id
      },
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

  /**
   * 商品画像設定時
   */
  $('#image').on('change', function () {

    if ($('#image').val() == '') {
      return;
    }

    var file = $('#image').prop('files')[0];

    // ファイル検証
    // 指定の拡張子以外の場合はアラート
    var permit_type = ['image/jpeg', 'image/png', 'image/gif'];
    if (file && permit_type.indexOf(file.type) == -1) {
      alert('この形式のファイルはアップロードできません');
      $('#image').val('');
      $('#sell_image_exists').val(false);
      return
    }

    // ブラウザがFileReaderに対応しているか
    if (!window.FileReader) {
      alert('サムネイルは表示されません');
      return;
    }

    var reader = new FileReader();
    // 画像を読み込んだ時にサムネイルを表示する
    reader.onload = function () {
      //1つしか画像を表示させないため、表示されている画像があれば削除する
      $('.sell-upload-picture').remove();
      $('#sell_image_exists').val(false);

      var html = `
      <li class="sell-upload-picture">
        <figure class="sell-upload-picture__figure">
          <img class="sell-upload-picture__figure__img">
        </figure>
        <div class="sell-upload-picture__buttons">
          <a class="sell-upload-picture__buttons__button">編集</a>
          <a class="sell-upload-picture__buttons__button sell-image-delete-btn">削除</a>
        </div>
      </li>`;
      var dom = $(html);
      dom.find('.sell-upload-picture__figure__img').attr('src', reader.result);
      $('.sell-dropbox__picture').append(dom);
      // サムネイルとDnDエリアを調整
      $('.sell-dropbox__pictures').removeClass('sell-dropbox__pictures--item0');
      $('.sell-dropbox__pictures').addClass('sell-dropbox__pictures--item1');
      $('.sell-dropbox-area').removeClass('sell-dropbox-area--item0');
      $('.sell-dropbox-area').addClass('sell-dropbox-area--item1');
      $('#sell_image_exists').val(true);
    }
    // 画像を読み込む
    reader.readAsDataURL(file);
  });

  /**
   * サムネイルに表示した商品画像の削除
   */
  $(document).on('click', '.sell-image-delete-btn', function () {
    $(this).parents('.sell-upload-picture').remove();
    // DnDエリアを調整
    $('.sell-dropbox__pictures').removeClass('sell-dropbox__pictures--item1');
    $('.sell-dropbox__pictures').addClass('sell-dropbox__pictures--item0');
    $('.sell-dropbox-area').removeClass('sell-dropbox-area--item1');
    $('.sell-dropbox-area').addClass('sell-dropbox-area--item0');
    $('#image').val('');
    $('#sell_image_exists').val(false);
  });

});