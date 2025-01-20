<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM of trait_debris
 */
class Traitdebris extends PpciModel
{

    private $sql = "select trait_debit_id, trait_id, debris_id,debris_quantite,
                  debris_name, unite_comptage
                  from trait_debris
                  join debris using (debris_id)
                  ";
    /**
     * Constructor
     *
     * @param PDO $bdd
     * @param array $param
     */
    public function __construct()
    {
        $this->table = "trait_debris";
        $this->fields = array(
            "trait_debit_id" => array("type" => 1, "requis" => 1, "defaultValue" => 0, "key" => 1),
            "trait_id" => array("type" => 1, "requis" => 1, "parentAttrib" => 1),
            "debris_id" => array("type" => 1, "requis" => 1),
            "debris_quantite" => array("type" => 0)
        );
        parent::__construct();
    }
    /**
     * Returns the list of debris of the trait
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
