<?php 
namespace App\Models;
use Ppci\Models\PpciModel;
class Station extends PpciModel
{

  public function __construct()
  {
    $this->table = "station";
    $this->fields = array(
      "station_id" => array("type" => 1, "requis" => 1, "key" => 1, "defaultValue"=>0),
      "station_code" => array("requis" => 1)
    );
    parent::__construct();
  }

  /**
   * Get all points of the polygon of the station
   *
   * @param int $station_id
   * @return array
   */
  function getPoints(int $station_id):array {
    $sql = "SELECT  ST_x(geom) as lat,ST_y(geom) as lon  FROM
    (SELECT (ST_dumppoints(geom)).geom FROM sturat.station where station_id = :id
    ) AS req";
    return $this->getListeParamAsPrepared($sql, array("id"=>$station_id));
  }
}
