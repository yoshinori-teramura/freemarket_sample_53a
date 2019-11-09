
$(document).on('turbolinks:load', function(){
  $(".category_choice-menu").hide();
  $(".header__bottom__left__list__link").hover(function() {
    $('.category_choice-menu:not(:animated)').slideDown("fast")
    },
    function(){
      $('.category_choice-menu').hover(function(){
      },
      function(){
      $(".category_choice-menu").hide();
      });
  });
});


$(document).on('turbolinks:load', function () {
  $(".category_choice-sub").hide();
  $(".category_choice__box").hover(function() {
    $(this).children('.category_choice-sub:not(:animated)').slideDown('fast')
    },
    function(){
      $('.category_choice-sub',this).slideUp("fast");    
  });
});
