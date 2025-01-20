<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM of echantillon
 */
class Echantillon extends PpciModel
{

    private $sql = "select echantillon_id, trait_id, espece_id,
                  weight, total_number, total_measured_number, total_death,
                  total_sample, sample_comment, weight_comment,
                  nom, nom_fr
                  from echantillon
                  join espece using (espece_id)
                  ";
    /**
     * Constructor
     *
     * @param PDO $bdd
     * @param array $param
     */
    public function __construct()
    {
        $this->table = "echantillon";
        $this->fields = array(
            "echantillon_id" => array("type" => 1, "requis" => 1, "defaultValue" => 0, "key" => 1),
            "trait_id" => array("type" => 1, "requis" => 1, "parentAttrib" => 1),
            "espece_id" => array("type" => 1, "requis" => 1),
            "weight" => array("type" => 1),
            "total_number" => array("type" => 1),
            "total_measured_number" => array("type" => 1),
            "total_death" => array("type" => 1),
            "total_sample" => array("type" => 1),
            "sample_comment" => array("type" => 0),
            "weight_comment" => array("type" => 0)
        );
        parent::__construct();
    }
    /**
     * Get the list of samples for a trait
     *
     * @param integer $trait_id
     * @return array|null
     */
    function getListFromTrait(int $trait_id): ?array
    {
        $where = " where trait_id = :trait_id:";
        return $this->getListeParamAsPrepared($this->sql . $where, array("trait_id" => $trait_id));
    }
    /**
     * Surround of lire to get the species name
     *
     * @param int $id
     * @param boolean $getDefault
     * @param integer $trait_id
     * @return array
     */
    function read($id, $getDefault = true, $trait_id = 0): array
    {
        if ($id == 0) {
            $data = $this->getDefaultValue($trait_id);
        } else {
            $data = $this->lireParamAsPrepared($this->sql . " where echantillon_id = :id:", array("id" => $id));
        }
        return $data;
    }
    function write($data): int
    {
        /**
         * Verification des donnees saisies
         */
        $recalculate = false;
        if ($data["total_number"] < $data["total_measured_number"]) {
            $data["total_number"] = $data["total_measured_number"];
            $recalculate = true;
        }
        if ($data["total_number"] < $data["total_death"]) {
            $data["total_number"] = $data["total_death"];
            $recalculate = true;
        }
        if ($data["total_number"] < $data["total_sample"]) {
            $data["total_number"] = $data["total_sample"];
            $recalculate = true;
        }
        if ($recalculate) {
            $this->addMessage(_("Le nombre total de poissons a été ajusté"));
        }
        return parent::write($data);
    }
}
