document.addEventListener('turbolinks:load', function() {
  // select2用
  $(".searchable").select2({
    width: 200,
    allowClear: true
  });

  // お気に入り用
  $("body").on("click", ".favorite-icon", function(){
      $(this).attr("class","fa fa-heart delete-icon");
      $(this).css("color", "red");
  });
  $("body").on("click", ".delete-icon", function(){
    $(this).attr("class","fa fa-heart favorite-icon");
    $(this).css("color", "gray");
  });

  // カレンダー登録用
  $("body").on("click", ".add-calendar", function(){
      $(this).attr("class","fa fa-calendar delete-calendar");
  });
  $("body").on("click", ".delete-calendar", function(){
    $(this).attr("class","fa fa-calendar-plus-o add-calendar");
  });
});

//テキストカウント用
document.addEventListener('turbolinks:load', function() {
  var check = $(".count").text($("#text_count").val());
  if(check.length){
    $(".count").text($("#text_count").val().length);

    $("#text_count").on("keydown keyup keypress change",function(){
      var text_length = $(this).val().length;
      var countup = text_length;
      $(".count").text(countup);
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