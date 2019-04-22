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


$(document).on('turbolinks:load',function(){
    //テキストカウント用
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

    // 新規追加におけるフォーム自動補完
    // 開場時間に合わせて開演、終演時間が補完される
    $(".event_new_container #open_date_form").one("blur", function(){
        const open_date = $(this).val();
        $("#start_date_form").val(open_date);
        $("#end_date_form").val(open_date);
    });
});
