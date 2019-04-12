// select2用
$(function() {
  return $(".searchable").select2({
    width: 200,
    allowClear: true
  });
});

// お気に入り用
$(function(){
  $(".fa-heart").on("click", function(){
    $(this).css("color", "red");
  });
  $(".fa-heart").on("click", function(){
    $(this).css("color", "gray");
  });
});



//テキストカウント用
$(function(){
  var check = $(".count").text($("#text_count").val());
  if(check.length){
    $(".count").text($("#text_count").val().length);

    $("#text_count").on("keydown keyup keypress change",function(){
        var text_length = $(this).val().length;
        var countup = text_length;
        $(".count").text(countup);
        // CSSは任意で
        if(countup > 200){
            $('.count').css({
                color:'#ff0000',
                fontWeight:'bold'
            });
        } else {
            $('.count').css({
                color:'#000000',
                fontWeight:'normal'
            });
        }
    });
  }
});