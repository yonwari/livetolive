// select2用
document.addEventListener('turbolinks:load', function() {
  return $(".searchable").select2({
    width: 200,
    allowClear: true
  });
});

// お気に入り用
document.addEventListener('turbolinks:load', function(){
    $("body").on("click", ".favorite-icon", function(){
        $(this).attr("class","fa fa-heart delete-icon");
        $(this).css("color", "red");
    });
    $("body").on("click", ".delete-icon", function(){
      $(this).attr("class","fa fa-heart favorite-icon");
      $(this).css("color", "gray");
    });
});
// カレンダー登録用
document.addEventListener('turbolinks:load', function(){
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


// 会場MAP表示用
function initEventMap() {

  var now ={lat: gon.place.latitude , lng: gon.place.longitude };
  var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 16,
      center: now
  });
  var transitLayer = new google.maps.TransitLayer();
  transitLayer.setMap(map);

  var contentString = `場所：${gon.place.address}`;
  var infowindow = new google.maps.InfoWindow({
      content: contentString
  });

  var marker = new google.maps.Marker({
      position:now,
      map: map,
      title: contentString
  });

  marker.addListener('click', function() {
      infowindow.open(map, marker);
  });
  var nearmap;
  var service;
  initialize();
}


// 近くのカフェ表示用
function initialize() {
  var pyrmont = new google.maps.LatLng(gon.place.latitude,gon.place.longitude);
  nearmap = new google.maps.Map(document.getElementById('nearmap'), {
      center: pyrmont,
      zoom: 15
  });

  //指定位置の半径1000m内のカフェを検索
  var request = {
    location: pyrmont,
    radius: '1000',
    type: ['cafe']
  };
  service = new google.maps.places.PlacesService(nearmap);
  service.nearbySearch(request, callback);

  EventPositionMarker(pyrmont);
}
function createMarker(latlng, icn, place)
{
  // マーカー作成
  var marker = new google.maps.Marker({
    position: latlng,
    map: nearmap,
  });

  var placename = place.name;
  // 吹き出しにカフェの名前を埋め込む
  var contentString = `<div class="sample"><p id="place_name">${placename}</p></div>`;

  // 吹き出し
  var infoWindow = new google.maps.InfoWindow({
    content:  contentString
  });

  marker.addListener('click', function() {
    infoWindow.open(map, marker);
  });
}
  // ライブ会場のアイコンを表示
function EventPositionMarker(pyrmont) {
    var image = 'http://i.stack.imgur.com/orZ4x.png';
    var marker = new google.maps.Marker({
            position: pyrmont,
            map: nearmap,
            icon: image
        });
    marker.setMap(nearmap);
}
function callback(results, status) {
  if (status == google.maps.places.PlacesServiceStatus.OK) {
    for (var i = 0; i < results.length; i++) {
      var place = results[i];
      latlng = place.geometry.location;
      icn = place.icon;
      createMarker(latlng, icn, place);
    }
  }
}