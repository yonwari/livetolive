// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require moment
//= require fullcalendar
//= require activestorage
//= require bootstrap-sprockets
//= require select2
//= require turbolinks
//= require_tree .

// TOPの人気ライブ一覧用
document.addEventListener('turbolinks:load', () => {
    new Swiper('.popular_lives', {
        loop: true,
        slidesPerView: 5,
        spaceBetween: 0,
        initialSlide: 0,
        breakpoints: {
          1024: {
            slidesPerView: 3,
            spaceBetween: 0
          },
          768: {
            slidesPerView: 2,
            spaceBetween: 0
          },
          425: {
            slidesPerView: 1,
            spaceBetween: 0
          }
        },
        autoplay: {
          speed: 2000,
          disableOnInteraction: true
        },
    });

    //Topイメージのスライド用
    $('.top_image').vegas({
        slides: [
            { src: 'assets/img/theater_D.jpg' },
            { src: 'assets/img/liveimage.jpg' },
            { src: 'assets/img/shibuyanight.jpg' },
        ],
        overlay: 'assets/overlays/03.png',
        transition: 'fade',
        transitionDuration: 3000,
        delay: 8000,
        animation: 'random',
        animationDuration: 10000,
    });
});


// fullcalendar用
$(function() {
    // 画面遷移を検知
    $(document).on('turbolinks:load', function () {
        // lengthを呼び出すことで、#calendarが存在していた場合はtrueの処理がされ、無い場合はnillを返す
        if ($('#calendar').length) {
            function eventCalendar() {
                return $('#calendar').fullCalendar({});
            };
            function clearCalendar() {
                $('#calendar').html('');
            };

            $(document).on('turbolinks:load', function () {
                eventCalendar();
            });
            $(document).on('turbolinks:before-cache', clearCalendar);

            $('#calendar').fullCalendar({
                events: `/users/${gon.user_id}.json`,
                //カレンダー上部を年月で表示させる
                titleFormat: 'YYYY年 M月',
                //ボタンのレイアウト
                header: {
                    left: 'prev',
                    center: 'title',
                    right: 'today next'
                },
                //終了時刻がないイベントの表示間隔
                defaultTimedEventDuration: '03:00:00',
                buttonText: {
                    prev: '前月',
                    next: '次月',
                    prevYear: '前年',
                    nextYear: '翌年',
                    today: '今日',
                    month: '月',
                    week: '週',
                    day: '日'
                },
                //イベントの時間表示を２４時間に
                timeFormat: "HH:mm",
                //イベントの色を変える
                eventColor: '#ff6347',
                //イベントの文字色を変える
                eventTextColor: '#000000',
            });
        }
    });
});

// 現在地から検索ボタン用
// 現在地を取得しsearchアクションに投げる
document.addEventListener('turbolinks:load', () => {
    $("#geosearch").on('click', function() {
        if( navigator.geolocation ){
            // 現在位置を取得できる場合の処理
            navigator.geolocation.getCurrentPosition(
                successCallback, errorCallback
            );
        } else {
        // 現在位置を取得できない場合の処理
            alert("現在地の取得に失敗しました");
        }

        function successCallback(position) {
            window.location.href = `/place/search?latitude=${position.coords.latitude}&longitude=${position.coords.longitude}`
        };
        function errorCallback(error) {
            let err_msg = "";
            switch(error.code)
            {
                case 1:
                    err_msg = "位置情報の利用が許可されていません";
                    break;
                case 2:
                    err_msg = "デバイスの位置が判定できません";
                    break;
                case 3:
                    err_msg = "タイムアウトしました";
                    break;
            }
        };
    });
});