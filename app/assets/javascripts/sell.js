$(document).on('turbolinks:load', function () {

  console.log("sell.js loaded");

  $('#sell-back-btn').on('click', function (e) {
    e.preventDefault();
    window.history.back();
  });
});