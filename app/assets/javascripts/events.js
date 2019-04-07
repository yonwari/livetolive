// select2用
$(function() {
  return $(".searchable").select2({
    width: 200,
    allowClear: true
  });
});

$(function(){
  $(".fa-heart").on("click", function(){
    $(this).css("color", "red");
  });
  $(".fa-heart").on("click", function(){
    $(this).css("color", "gray");
  });
});