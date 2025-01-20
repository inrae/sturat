<?php 
namespace App\Models;
use Ppci\Models\PpciModel;

/**
 * ORM of trait_geom
 */
class Traitgeom extends PpciModel
{
  private $sql = "select trait_id, longitude_start, longitude_end,
                  latitude_start, latitude_end,
                  trait_length from trait_geom";
  /**
   * Constructor
   *
   * @param PDO $bdd
   * @param array $param
   */
  public function __construct()
  {
    $this->table = "trait_geom";
    $this->fields = array(
      "trait_id" => array("type" => 1, "requis" => 1, "key"=>1),
      "longitude_start" => array("type" => 1),
      "latitude_start" => array("type" => 1),
      "longitude_end" => array("type" => 1),
      "latitude_end" => array("type" => 1),
      "trait_length" => array("type" => 1),
      "geom_segment" => array("type" => 4)
    );
    $this->useAutoIncrement = false;
    $this->srid = 4326;
    parent::__construct();
  }
  /**
   * Get the detail of the trait_geom
   *
   * @param integer $trait_id
   * @return array|null
   */
  function getDetail(int $trait_id): ?array
  {
    $where = " where trait_id = :trait_id";
    return ($this->lireParamAsPrepared($this->sql . $where, array("trait_id" => $trait_id)));
  }

  /**
   * Generate the geometric line
   *
   * @param array $data
   * @return int
   */
  function write($data)
  {
    if (!empty($data["longitude_start"]) && !empty($data["latitude_start"] && !empty("longitude_end") && !empty("latitude_end"))) {
      $data["geom_segment"] = "LINESTRING(" . $data["longitude_start"] . " " . $data["latitude_start"] . "," . $data["longitude_end"] . " " . $data["latitude_end"] . ")";
    } else {
      $data["geom_segment"] = "";
    }
    return parent::write($data);
  }
}
