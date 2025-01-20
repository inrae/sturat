<?php 
namespace App\Models;
use Ppci\Models\PpciModel;

/**
 * ORM of the table sonde
 */
class Sonde extends PpciModel
{
  public function __construct()
  {
    $this->table = "sonde";
    $this->fields = array(
      "sonde_id" => array("type" => 1, "key" => 1, "defaultValue" => 0, "requis" => 1),
      "trait_id" => array("type" => 1, "requis" => 1, "parentAttrib" => 1),
      "probe_date" => array("type" => 3, "requis" => 1),
      "depth" => array("type" => 1, "requis" => 1),
      "conductivity" => array("type" => 1),
      "conductivity_specific" => array("type" => 1),
      "salinity" => array("type" => 1),
      "oxygen_ppt" => array("type" => 1),
      "oxygen_mgl" => array("type" => 1),
      "turbidity" => array("type" => 1),
      "ph" => array("type" => 1),
      "temperature" => array("type" => 1)
    );
    parent::__construct();
  }
}
