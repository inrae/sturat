<!-- leaflet -->
<link rel="stylesheet" href="display/node_modules/leaflet/dist/leaflet.css">
<script src="display/node_modules/leaflet/dist/leaflet.js"></script>
<script src="display/node_modules/pouchdb/dist/pouchdb.min.js"></script>
<script src="display/node_modules/leaflet.tilelayer.pouchdbcached/L.TileLayer.PouchDBCached.js"></script>
<script src="display/node_modules/leaflet-mouse-position/src/L.Control.MousePosition.js"></script>
<script src="display/node_modules/leaflet-easyprint/dist/bundle.js"></script>
<script>
    /**
	 * Truncate a decimal field
	 */
	function truncator(number, digits) {
		return (number.toFixed(digits));
	}
    /**
	 * Transform a GPS coordinate to degree-minute
	 */
	function toDegreesMinutes(coordinate, latlon) {
		if (coordinate.length > 0) {
			var absolute = Math.abs(coordinate);
			var degrees = Math.floor(absolute);
			var minutes = truncator((absolute - degrees) * 60, 3);
			var cardinal = "N";
			if (latlon == "lat") {
				if (coordinate < 0) {
					cardinal = "S";
				}
			} else {
				if (coordinate > 0) {
					cardinal = "E";
				} else {
					cardinal = "W";
				}
			}
			return degrees + "°" + minutes + " " + cardinal;
		}
	}
</script>