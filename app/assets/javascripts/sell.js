$(document).on('turbolinks:load', function () {

  $('#sell-back-btn').on('click', function (e) {
    e.preventDefault();
    window.history.back();
  });

  $('#sell-input-price').on('keyup', function (e) {
    var input = this.value;

    if (input.length === 0 || isNaN(input)) {
      resetSellPrice();
      return false;
    }

    if(input < 300 || 9999999 < input) {
      resetSellPrice();
      return false;
    }

    var price = Number(input);
    var tax = Math.round(price / 10);
    var profit = price - tax;

    $(".sell-form-price__tax--right").text('¥' + tax.toLocaleString());
    $(".sell-form-price__profit--right").text('¥' + profit.toLocaleString());

  });

  function resetSellPrice() {
    $(".sell-form-price__tax--right").text("-");
    $(".sell-form-price__profit--right").text("-");
  }

});