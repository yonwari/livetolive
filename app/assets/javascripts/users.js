$(function(){
  // モーダル表示用
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



// マイページMAP表示用
function initMyMap() {

    var locations = gon.places;
    if (locations.length > 0) {
        var map = new google.maps.Map(document.getElementById('my_map'), {
            zoom: 11,
            center: new google.maps.LatLng(locations[0]["latitude"], locations[0]["longitude"]),
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
                    infowindow.open(my_map, marker);
                }
            })(marker, i));
        }
    }else {
        var map = new google.maps.Map(document.getElementById('my_map'), {
            zoom: 12,
            center: new google.maps.LatLng(35.681236, 139.767125),
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });
    }
}
