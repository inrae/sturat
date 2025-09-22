<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM of table trait_trace
 */
class Traittrace extends PpciModel
{

    /**
     * Constructor
     *
     * @param PDO $bdd
     * @param array $param
     */
    public function __construct()
    {
        $this->table = "trait_trace";
        $this->fields = array(
            "trait_id" => array("type" => 1, "key" => 1, "requis" => 1),
            "trace_geom" => array("type" => 4)
        );
        $this->srid = 4326;
        $this->useAutoIncrement = false;
        parent::__construct();
    }
    /**
     * Get all points of a trace in json array
     *
     * @param integer $trait_id
     * @return string|null
     */
    function getPoints(int $trait_id): ?string
    {
        $points = "";
        $sql = "select st_asgeojson(trace_geom)::json->'coordinates' as coordinates
            from sturat.trait_trace where trait_id = :trait_id:";
        $res = $this->lireParamAsPrepared($sql, array("trait_id" => $trait_id));
        $points = $res["coordinates"];
        return $points;
    }
    /**
     * rewrite write function to record geometry trace
     *
     * @param array $data
     * @return integer
     */
    function write($data): int
    {
        /**
         * check if exists
         */
        $sql = "SELECT trait_id from trait_trace where trait_id = :trait_id:";
        $last = $this->readParam($sql, ["trait_id" => $data["trait_id"]]);
        if ($last["trait_id"] > 0) {
            $sql = "UPDATE trait_trace 
                set trace_geom = st_geomfromtext(:geom:, :srid:)
                where trait_id = :trait_id:";
        } else {
            $sql = "INSERT into trait_trace (trait_id, trace_geom) values (:trait_id:, st_geomfromtext(:geom:, :srid:))";
        }
        $param = [
            "trait_id" => $data["trait_id"],
            "geom" => $data["trace_geom"],
            "srid" => $this->srid
        ];
        $this->executeSQL($sql, $param, true);
        return $data["trait_id"];
    }
}
