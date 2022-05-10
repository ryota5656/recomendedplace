

var map;
var Marker;
function initialize() {
    if (!navigator.geolocation) {
        alert('Geolocation APIに対応していません');
        return false;
    }

    // 現在地の取得
    navigator.geolocation.getCurrentPosition(function(position) {

        // 緯度経度の取得
        latLng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);

        // 地図の作成
        map = new google.maps.Map(document.getElementById('map_canvas'), {
            center: latLng,
            zoom: 17,
            mayTypeId: google.maps.MapTypeId.ROADMAP
        });

        // マーカーの追加
        Marker = new google.maps.Marker({
            position: latLng,
            map: map
        });

        // Create the search box and link it to the UI element.
        const input = document.getElementById("pac-input");
        const searchBox = new google.maps.places.SearchBox(input);

        map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
        // Bias the SearchBox results towards current map's viewport.
        map.addListener("bounds_changed", () => {
          searchBox.setBounds(map.getBounds());
        });

        let markers = [];

        // Listen for the event fired when the user selects a prediction and retrieve
        // more details for that place.
        searchBox.addListener("places_changed", () => {
          const places = searchBox.getPlaces();

          if (places.length == 0) {
            return;
          }

          // Clear out the old markers.
          markers.forEach((marker) => {
            marker.setMap(null);
          });
          markers = [];

          // For each place, get the icon, name and location.
          const bounds = new google.maps.LatLngBounds();

          places.forEach((place) => {
            if (!place.geometry || !place.geometry.location) {
              console.log("Returned place contains no geometry");
              return;
            }

            const icon = {
              url: place.icon,
              size: new google.maps.Size(71, 71),
              origin: new google.maps.Point(0, 0),
              anchor: new google.maps.Point(17, 34),
              scaledSize: new google.maps.Size(25, 25),
            };

            // Create a marker for each place.
            markers.push(
              new google.maps.Marker({
                map,
                icon,
                title: place.name,
                position: place.geometry.location,
              })
            );
            if (place.geometry.viewport) {
              // Only geocodes have viewport.
              bounds.union(place.geometry.viewport);
            } else {
              bounds.extend(place.geometry.location);
            }
          });
          map.fitBounds(bounds);
        });

        //地図クリックイベントの登録
        google.maps.event.addListener(map, 'click',
          function(event) {
            if (Marker){Marker.setMap(null)};
            Marker = new google.maps.Marker({
              position: event.latLng,
              draggable: true,
              map: map
            });
            infotable(Marker.getPosition().lat(),
            Marker.getPosition().lng(),map.getZoom());
            geocode();
            //マーカードラッグイベントの登録
            google.maps.event.addListener(Marker,'dragend',
            function(event) {
              infotable(Marker.getPosition().lat(),
              Marker.getPosition().lng(),map.getZoom());
              geocode();
            })
            //地図ズームチェンジイベントの登録
            google.maps.event.addListener(map, 'zoom_changed',
            function(event) {
            infotable(Marker.getPosition().lat(),
            Marker.getPosition().lng(),map.getZoom());
            })
          })

        //ジオコーディング
        function geocode(){  var geocoder = new google.maps.Geocoder();
          geocoder.geocode({ 'location': Marker.getPosition()},
            function(results, status) {
          if (status == google.maps.GeocoderStatus.OK && results[0]){
            document.getElementById('id_address').innerHTML =
                results[0].formatted_address.replace(/^日本, /, '');
          }else{
            document.getElementById('id_address').innerHTML =
              "Geocode 取得に失敗しました";
            alert("Geocode 取得に失敗しました reason: "
                  + status);
          }
          });
        }
        //HTMLtagを更新
        function infotable(ido,keido,level){
          document.getElementById('id_ido').innerHTML = ido;
          document.getElementById('id_keido').innerHTML = keido;
          document.getElementById('id_level').innerHTML = level;
          document.getElementById("lat").value = ido;
          document.getElementById("lng").value = keido;
        }
    }, function() {
        alert('位置情報取得に失敗しました');

        var latlng = new google.maps.LatLng(35.68032,139.7666);
        var opts = {
         zoom: 15,
         center: latlng,
         mapTypeId: google.maps.MapTypeId.ROADMAP
        }

        map = new google.maps.Map
        (document.getElementById("map_canvas"),opts);

       //地図クリックイベントの登録
        google.maps.event.addListener(map, 'click',
        function(event) {
         if (Marker){Marker.setMap(null)};
         Marker = new google.maps.Marker({
          position: event.latLng,
          draggable: true,
          map: map
         });
         infotable(Marker.getPosition().lat(),
         Marker.getPosition().lng(),map.getZoom());
         geocode();
         //マーカードラッグイベントの登録
         google.maps.event.addListener(Marker,'dragend',
          function(event) {
          infotable(Marker.getPosition().lat(),
          Marker.getPosition().lng(),map.getZoom());
          geocode();
         })
         //地図ズームチェンジイベントの登録
         google.maps.event.addListener(map, 'zoom_changed',
          function(event) {
          infotable(Marker.getPosition().lat(),
          Marker.getPosition().lng(),map.getZoom());
         })
        })
       //ジオコーディング
        function geocode(){  var geocoder = new google.maps.Geocoder();
         geocoder.geocode({ 'location': Marker.getPosition()},
            function(results, status) {
          if (status == google.maps.GeocoderStatus.OK && results[0]){
            document.getElementById('id_address').innerHTML =
                results[0].formatted_address.replace(/^日本, /, '');
          }else{
            document.getElementById('id_address').innerHTML =
              "Geocode 取得に失敗しました";
           alert("Geocode 取得に失敗しました reason: "
                  + status);
          }
         });
        }

       //HTMLtagを更新
        function infotable(ido,keido,level){
         document.getElementById('id_ido').innerHTML = ido;
         document.getElementById('id_keido').innerHTML = keido;
         document.getElementById('id_level').innerHTML = level;
         document.getElementById("lat").value = ido;
         document.getElementById("lng").value = keido;
        }
    });


}
