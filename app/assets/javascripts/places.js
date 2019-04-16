// ライブ会場詳細ページ用
function initPlaceMap() {

  var point ={lat: gon.place["latitude"] , lng: gon.place["longitude"] };
  var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 16,
      center: point
  });
  var transitLayer = new google.maps.TransitLayer();
  transitLayer.setMap(map);

  var contentString = `場所：${gon.place.address}`;
  var infowindow = new google.maps.InfoWindow({
      content: contentString
  });

  var marker = new google.maps.Marker({
      position:point,
      map: map,
      title: contentString
  });

  marker.addListener('click', function() {
      infowindow.open(map, marker);
  });
}



// 近くの会場検索用
function initSearchMap() {

    var locations = gon.places;
    if (locations.length > 0) {
        var map = new google.maps.Map(document.getElementById('near_map'), {
            zoom: 14,
            center: new google.maps.LatLng(gon.latitude, gon.longitude),
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });

        var infowindow = new google.maps.InfoWindow;
        var marker, i;

        for (i = 0; i < locations.length; i++) {
            marker = new google.maps.Marker({
                position: new google.maps.LatLng(locations[i]["latitude"], locations[i]["longitude"]),
                map: map
            });

            google.maps.event.addListener(marker, 'click', (function(marker, i) {
                return function() {
                    infowindow.setContent(locations[i]["place_name"]);
                    infowindow.open(map, marker);
                }
            })(marker, i));
        }
    }else {
        var map = new google.maps.Map(document.getElementById('near_map'), {
            zoom: 14,
            center: new google.maps.LatLng(35.681236, 139.767125),
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });
    }
}
