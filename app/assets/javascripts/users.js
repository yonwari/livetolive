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
});