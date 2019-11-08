$(document).on('turbolinks:load', function () {
  $(function() {
    // mouseoverを使用
    $(".category_choice__box").hover(function() {
      $(this).children('.category_choice-sub:not(:animated)').slideToggle();    
    });
  });
});

$(document).on('turbolinks:load', function(){
  $(function() {
    // mouseoverを使用
    $(".header__bottom__left__list__link").hover(function() {
      $('.category_choice-menu:not(:animated)').slideToggle();    
    });
  });
});