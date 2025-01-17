<div id="map" class="map"></div>
{include file="mapDefault.tpl"}
<script>
  function setPosition(pointnum, lat, lon, pos) {
    if (startend[pointnum] == undefined) {
      startend[pointnum] = L.marker([lat, lon]).bindTooltip(pos, { permanent: true, className: "transparent-tooltip" });
      startend[pointnum].addTo(map);
    } else {
      startend[pointnum].setLatLng([lat, lon]);
    }
    if (pointnum == 0) {
      map.setView([lat, lon]);
    }

  }
  function setDefaultPosition(lat, lon) {
    if (lat.length > 0 && lon.length > 0) {
      mapData.mapDefaultLong = lon;
      mapData.mapDefaultLat = lat;
      map.setView([lat, lon]);
    }
  }
  function setStationPoints(sp) {
    console.log(sp);
    station = [];
    sp.forEach(function (element, i) {
      station[i] = [element["lon"], element["lat"]];
    });
    if (polygon == undefined) {
      polygon = L.polygon(station, polygonOptions).addTo(map);
    } else {
      polygon.setLatLngs(station);
    }
  }
  var mapIsChange = false;
  var map = setMap("map");
  var startlon = "{$geom.longitude_start}";
  var startlat = "{$geom.latitude_start}";
  var endlon = "{$geom.longitude_end}";
  var endlat = "{$geom.latitude_end}";
  var startend = [];
  try {
    var trace = JSON.parse("{$trace}");
  } catch (error) {
    var trace = [];
  }

  var points = [];
  trace.forEach(function (element, i) {
    points[i] = [element[1], element[0]];
  });
  try {
    var stationPoints = JSON.parse('{$stationPoints}');
  } catch (error) {
    var stationPoints = [];
  }
  var station = [];
  var polygon ;
  var polygonOptions = {
    color:'red'
  };
  setStationPoints(stationPoints);

  mapDisplay(map);
  if (startlon.length > 0 && startlat.length > 0) {
    setPosition(0, startlat, startlon, "{t}Début{/t}");
  }
  if (endlon.length > 0 && endlat.length > 0) {
    setPosition(1, endlat, endlon, "{t}Fin{/t}");
  }
  if (points.length > 0) {
    var polyline = L.polyline(points);
    polyline.addTo(map);
  }

  if (mapIsChange == true) {
    map.on('click', function (e) {
      setPosition(e.latlng.lat, e.latlng.lng);
      $("#location_long").val(e.latlng.lng);
      $("#location_lat").val(e.latlng.lat);
    });
    $("#radar").click(function () {
      if (navigator && navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function (position) {
          var lon = position.coords.longitude;
          var lat = position.coords.latitude;
          setPosition(lat, lon);
          $("#location_long").val(lon);
          $("#location_lat").val(lat);
        });
      }
    });
  }


</script>
