$(document).on('turbolinks:load',function(){
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
$(document).on('turbolinks:load',function(){
    let check = $(".count").text($("#text_count").val());

    if(check.length){
        $(".count").text($("#text_count").val().length);
        $("#text_count").on("keydown keyup keypress change",function(){
            let text_length = $(this).val().length;
            let countup = text_length;
            $(".count").text(countup);
            if(countup > 200){
                $('.count').attr("class", "count text_count_ng");
            } else {
                $('.count').attr("class", "count text_count_ok");
            }
        });
    }
});