<?php 
namespace App\Models;
use Ppci\Models\PpciModel;

/**
 * ORM of table trait_trace
 */
class Traittrace extends PpciModel
{

  /**
   * Constructor
   *
   * @param PDO $bdd
   * @param array $param
   */
  public function __construct()
  {
    $this->table = "trait_trace";
    $this->fields = array(
      "trait_id" => array("type" => 1, "key" => 1, "requis" => 1),
      "trace_geom" => array("type" => 4)
    );
    $this->srid = 4326;
    $this->useAutoIncrement = false;
    parent::__construct();
  }
  /**
   * Get all points of a trace in json array
   *
   * @param integer $trait_id
   * @return string|null
   */
  function getPoints(int $trait_id): ?string
  {
    $points = "";
    $sql = "select st_asgeojson(trace_geom)::json->'coordinates' as coordinates
            from sturat.trait_trace where trait_id = :trait_id";
    $res = $this->lireParamAsPrepared($sql, array("trait_id" => $trait_id));
    $points = $res["coordinates"];
    return $points;
  }
}
