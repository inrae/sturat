<?php

namespace App\Models;

use Ppci\Models\PpciModel;

class EnginType extends PpciModel
{

    public function __construct()
    {
        $this->table = "engin_type";
        $this->fields = array(
            "engin_type_id" => array("type" => 1, "requis" => 1, "key" => 1, "defaultValue" => 0),
            "engin_type_libelle" => array("requis" => 1),
            "engin_type_description" => array("type" => 0)
        );
        parent::__construct();
    }
}
