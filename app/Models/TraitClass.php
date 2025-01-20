<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM of table trait
 */
class TraitClass extends PpciModel
{

    private $sql = "select trait_id, trait_start, trait_end, duration, engin_type_id, station_id,
                  maree_id, maree_coef, remarks
                  ,station_code, maree_libelle, engin_type_libelle
                  from trait
                  join station using (station_id)
                  left outer join maree using (maree_id)
                  left outer join engin_type using (engin_type_id)";
    /**
     * Constructor
     */
    public function __construct()
    {
        $this->table = "trait";
        $this->fields = array(
            "trait_id" => array("type" => 1, "requis" => 1, "key" => 1, "defaultValue" => 0),
            "trait_start" => array("requis" => 1, "type" => 3, "defaultValue" => "getDateHeure"),
            "trait_end" => array("type" => 3, "defaultValue" => "getDateHeure"),
            "duration" => array("type" => 0, "defaultValue" => "00:30:00"),
            "engin_type_id" => array("type" => 1, "defaultValue" => 3),
            "station_id" => array("type" => 1, "requis" => 1),
            "maree_id" => array("type" => 1, "defaultValue" => 1),
            "maree_coef" => array("type" => 1),
            "remarks" => array("type" => 0)
        );
        parent::__construct();
    }
    /**
     * Search traits from parameters
     *
     * @param array $param
     * @return array|null
     */
    function search(array $param): ?array
    {
        $data = array();
        $and = "";
        $where = " where ";
        if (!empty($param["trait_id"])) {
            $where .= " trait_id = :trait_id:";
            $data["trait_id"] = $param["trait_id"];
            $and = " and ";
        } else {
            if (!empty($param["station_id"])) {
                $where .= $and . "station_id = :station_id:";
                $data["station_id"] = $param["station_id"];
                $and = " and ";
            }
            if (!empty($param["from"]) && !empty($param["to"])) {
                $where .= $and . "trait_start::date between :from: and :to:";
                $data["from"] = $this->formatDateLocaleVersDB($param["from"]);
                $data["to"] = $this->formatDateLocaleVersDB($param["to"]);
                $and = " and ";
            }
        }
        if (empty($and)) {
            return array();
        } else {
            return $this->getListeParamAsPrepared($this->sql . $where, $data);
        }
    }
    /**
     * Get the detail of a trait
     *
     * @param integer $trait_id
     * @return array|null
     */
    function getDetail(int $trait_id): ?array
    {
        $where = " where trait_id = :trait_id:";
        return $this->lireParamAsPrepared($this->sql . $where, array("trait_id" => $trait_id));
    }
    /**
     * Delete a trait with all children
     *
     * @param integer $trait_id
     * @return int
     */
    function supprimer($trait_id)
    {
        $children = [
            "Traitgeom",
            "Traittrace",
            "Physicochimie",
            "Echantillon",
            "Traitdebris",
            "IndividuSturio",
            "Eel",
            "Sonde"
        ];
        foreach ($children as $child) {
            $name = "App\Models\\$child";
            $childInstance = new $name;
            $childInstance->supprimerChamp($trait_id, "trait_id");
        }
        $sql = "delete from trait_manipulateur where trait_id = :trait_id";
        $this->executeAsPrepared($sql, array("trait_id" => $trait_id));
        return parent::supprimer($trait_id);
    }
}
