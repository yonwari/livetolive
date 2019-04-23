// MAP呼び出し
document.addEventListener('turbolinks:load', () => {
    initMap();
    initCafe();
});

// GoogleMAP表示用
const initMap = () => {
    const locations = gon.places;
    if (document.querySelector('.map') != null) {
        // default値
        const mapOptions = {
            zoom: 12,
            center: new google.maps.LatLng(35.681236, 139.767125),
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        // 条件によってはdefault値を上書き
        if (locations.length > 0) {
            mapOptions['zoom'] = 13;
            mapOptions['center'] = new google.maps.LatLng(locations[0]["latitude"], locations[0]["longitude"]);
        }

        // map初期化
        const map = new google.maps.Map(document.querySelector('.map'), mapOptions);

        // 変数準備
        let marker;
        let infowindow = new google.maps.InfoWindow;

        // マーカー、ウインドウ作成
        locations.forEach(location => {
            marker = new google.maps.Marker({
                position: new google.maps.LatLng(location["latitude"], location["longitude"]),
                map: map
            });
            google.maps.event.addListener(marker, 'click', ((marker) => {
              return () => {
                  infowindow.setContent(location["place_name"]);
                  infowindow.open(map, marker);
              }
            })(marker));
        });
    }
}

// 近くのカフェ表示用
const initCafe = () => {
    if (document.querySelector('#nearmap') != null) {
        // ライブ会場の座標作る
        const event_place = new google.maps.LatLng(gon.place.latitude,gon.place.longitude);
        // MAP初期化（ライブ会場がセンター）
        nearmap = new google.maps.Map(document.querySelector('#nearmap'), {
            center: event_place,
            zoom: 15
        });
        //指定位置の半径500m内のカフェを検索
        const request = {
            location: event_place,
            radius: '500',
            type: ['cafe']
        };
        const service = new google.maps.places.PlacesService(nearmap);
        service.nearbySearch(request, callback);
        // イベント会場をマーカー表示
        EventPositionMarker(event_place);
    }
}

// 近隣カフェマーカー作成
const createMarker = (latlng, place) => {
    // マーカー作成
    var marker = new google.maps.Marker({
        position: latlng,
        map: nearmap,
    });
    // 吹き出しにカフェの名前を埋め込む
    var contentString = `<div class="sample"><p id="place_name">${place.name}</p></div>`;
    // 吹き出し成形
    var infoWindow = new google.maps.InfoWindow({
        content:  contentString
    });
    // クリックされたら吹き出し表示
    marker.addListener('click', function() {
        infoWindow.open(map, marker);
    });
}

// ライブ会場のアイコンを表示
const EventPositionMarker = (event_place) => {
    const image = 'http://i.stack.imgur.com/orZ4x.png';
    const event_marker = new google.maps.Marker({
        position: event_place,
        map: nearmap,
        icon: image
    });
    event_marker.setMap(nearmap);
}

// servise.nearBySearchのコールバック
// 近隣カフェ情報を受け取り、マーカー作成メソッドに個数分投げる
const callback = (results, status) => {
    if (status === google.maps.places.PlacesServiceStatus.OK) {
        results.forEach(place => {
            var latlng = place.geometry.location;
            var place = place;
            createMarker(latlng, place);
        });
    }
}
