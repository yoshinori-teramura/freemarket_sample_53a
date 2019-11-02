
$(function(){
  setInterval(function(){
    $('#slide1').toggleClass("invisible");
    $('#slide2').toggleClass("invisible");
  },3000);
});

$(function(){
  $('button').click(function() {
    $('#slide1').toggleClass("invisible");
    $('#slide2').toggleClass("invisible");
  });
});

