<?php

namespace App\Models;

use Ppci\Models\PpciModel;

class Cinna extends PpciModel
{
    protected $DBGroup = 'cinna';

    function __construct()
    {
        $this->table = "cinna";
        $this->fields = array(
            "cinna_id" => array("key" => 1, "type" => 1),
            "cinnadate" => array("type" => 3),
            "val" => array("type" => 1),
            "unit_id" => array("type" => 1),
            "parameter_id" => array("type" => 1),
            "lon" => array("type" => 1),
            "lat" => array("type" => 1),
            "geom" => array("type" => 4)
        );
        $this->autoFormatDate = false;
        $this->srid = 4326;
        parent::__construct();
    }


    function getLatLonRMC($line)
    {

        $latLon = array("lat" => $line[4], "lon" => $line[6]);
        if ($line[7] == "W") {
            $latLon["lon"] = $latLon["lon"] * -1;
        }
        return $latLon;
    }

    function test() {
        return $this->readParam("select count(*) from cinna");
    }

    function getLatLonGGA($line): array
    {
        /**
         * Latitude
         */
        $lat = (int)substr($line[3], 0, 2) + (floatval(substr($line[3], 2))) / 60;
        if ($line[4] == "S") {
            $lat = $lat * -1;
        }
        $lon = (int)substr($line[5], 0, 3) + (floatval(substr($line[5], 3))) / 60;
        if ($line[6] == "W") {
            $lon = $lon * -1;
        }
        return (array("lat" => $lat, "lon" => $lon));
    }

    /**
     * Verify if the coordinates are not in the harbour of Royan
     *
     * @param array $latLon
     * @return boolean
     */
    function verifyLatLon(array $latLon): bool
    {
        if ($latLon["lat"] > 45.61 && $latLon["lat"] < 45.63 && $latLon["lon"] >= -1.03 && $latLon["lon"] <= -1.02) {
            /**
             * Coordonnées du port de Royan
             */
            return false;
        } else {
            return true;
        }
    }

    /**
     * Format the date to the database
     *
     * @param string $date
     * @return string
     */
    function formatDate(string $date): string
    {
        return "20" . substr($date, 0, 2) . "-" . substr($date, 2, 2) . "-" . substr($date, 4, 2) . " " . substr($date, 6, 2) . ":" . substr($date, 8, 2) . ":" . substr($date, 10, 2);
    }
}
