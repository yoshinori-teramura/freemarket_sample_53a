$(document).on('turbolinks:load', function () {

  // 別ページから遷移すると使用できない
  $('#sell-back-btn').on('click', function(e) {
    e.preventDefault();
    window.history.back();
  });
});