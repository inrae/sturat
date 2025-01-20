<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM of individu
 */
class Individu extends PpciModel
{

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->table = "individu";
        $this->fields = array(
            "individu_id" => array("type" => 1, "requis" => 1, "defaultValue" => 0, "key" => 1),
            "echantillon_id" => array("type" => 1, "requis" => 1, "parentAttrib" => 1),
            "fork_length" => array("type" => 1),
            "weight" => array("type" => 1),
            "total_length" => array("type" => 1)
        );
        parent::__construct();
    }
}
