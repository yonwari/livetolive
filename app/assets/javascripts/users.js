$(document).on('turbolinks:load',function(){
    // ユーザー編集モーダル表示用
    $('#edit-user').on('click',function(){
        $('#overlay,#result').fadeIn();
    });
    $('#close,#overlay').on('click', function(){
        $('#overlay,#result').fadeOut();
    });
    $('#result').on('click', function(e){
        e.stopPropagation();
    });

    // お気に入りまでのスクロール用
    $('#to_favs').on('click', function(){
        $("html,body").animate({scrollTop:$('#favorites_container').offset().top});
    });
});
