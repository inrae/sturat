<?php

namespace App\Models;

use Ppci\Models\PpciModel;

class Physicochimie extends PpciModel
{
    public function __construct()
    {
        $this->table = "physicochimie";
        $this->fields = array(
            "trait_id" => array("type" => 1, "requis" => 1, "key" => 1, "parentAttrib" => 1),
            "temperature" => array("type" => 1),
            "conductivity" => array("type" => 1),
            "conductivity_specific" => array("type" => 1),
            "salinity" => array("type" => 1),
            "depth" => array("type" => 1),
            "depth_probe" => array("type" => 1),
            "oxygen_ppt" => array("type" => 1),
            "oxygen_mgl" => array("type" => 1),
            "turbidity" => array("type" => 1),
            "ph" => array("type" => 1),
            "comment" => array("type" => 0)
        );
        $this->useAutoIncrement = false;
        parent::__construct();
    }
}
