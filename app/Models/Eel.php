<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM of table individu_eel
 */
class Eel extends PpciModel
{

    private $sql = "select individu_eel_id, trait_id, eel_stade_id,
                  total_length, hori_diam_eyepiece,
                  vert_diam_eyepiece, pectoral_length,
                  observation,
                  val_oi, val_iln, val_j,val_a,
                  fork_length, weight,
                  eel_stade_name
                  from individu_eel
                  left outer join eel_stade using (eel_stade_id)";

    /**
     * Constructor
     *
     * @param PDO $bdd
     * @param array $param
     */
    public function __construct()
    {
        $this->table = "individu_eel";
        $this->fields = array(
            "individu_eel_id" => array("type" => 1, "key" => 1, "defaultValue" => 0, "requis" => 1),
            "trait_id" => array("type" => 1, "requis" => 1, "parentAttrib" => 1),
            "total_length" => array("type" => 1),
            "hori_diam_eyepiece" => array("type" => 1),
            "vert_diam_eyepiece" => array("type" => 1),
            "pectoral_length" => array("type" => 1),
            "observation" => array("type" => 0),
            "val_oi" => array("type" => 1),
            "val_iln" => array("type" => 1),
            "val_j" => array("type" => 1),
            "val_a" => array("type" => 1),
            "eel_stade_id" => array("type" => 1),
            "fork_length" => array("type" => 1),
            "weight" => array("type" => 1)
        );
        parent::__construct();
    }

    /**
     * Get the list of eels catched in a trait
     *
     * @param integer $trait_id
     * @return array|null
     */
    function getListFromTrait(int $trait_id): ?array
    {
        $where = " where trait_id = :trait_id:";
        return $this->getListeParamAsPrepared($this->sql . $where, array("trait_id" => $trait_id));
    }
}
