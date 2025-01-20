<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM of table prelevement
 */
class Prelevement extends PpciModel
{

    public function __construct()
    {
        $this->table = "prelevement";
        $this->fields = array(
            "prelevement_id" => array("type" => 1, "key" => 1, "defaultValue" => 0, "requis" => 1),
            "individu_sturio_id" => array("type" => 1, "requis" => 1, "parentAttrib" => 1),
            "prelevement_localisation_id" => array("type" => 1),
            "fin_id" => array("type" => 1),
            "prelevement_type_id" => array("type" => 1, "requis" => 1),
            "prelevement_ref" => array("type" => 0),
            "prelevement_comment" => array("type" => 0),
            "blood_quantity" => array("type" => 1),
            "mucus_sampling" => array("type" => 1)
        );
        parent::__construct();
    }
}
