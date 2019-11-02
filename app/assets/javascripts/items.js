$(function(){
  $(document).on('click', '.main__popularCategory__content__topics__1topic__link', function(){
    var id = $(this).data('category-id');

    $('html,body').animate({
      scrollTop: $(`#category_${id}`).offset().top
    }, 300);
  })
});