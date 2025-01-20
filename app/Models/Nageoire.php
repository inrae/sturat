<?php

namespace App\Models;

use Ppci\Models\PpciModel;

class Nageoire extends PpciModel
{

    public function __construct()
    {
        $this->table = "nageoire";
        $this->fields = array(
            "fin_id" => array("type" => 1, "requis" => 1, "key" => 1, "defaultValue" => 0),
            "fin_name" => array("requis" => 1)
        );
        parent::__construct();
    }
}
