<?php

namespace App\Models;

/**
 * Parameters for searching traits
 *
 * @author quinton
 *
 */
class SearchTrait extends SearchParam
{
    public function __construct()
    {
        $this->param = array(
            "station_id" => "",
            "from" => "",
            "to" => "",
            "trait_id" => "",
            "trace_import_from" => "",
            "trace_import_to" => ""
        );
        /**
         * Ajout des dates
         */
        $this->reinit();
        $this->paramNum = array(
            "station_id"
        );
        parent::__construct();
    }
    function reinit()
    {
        $ds = new \DateTime();
        $ds->modify("-1 month");
        $this->param["from"] = $ds->format($_SESSION["date"]["maskdate"]);
        $this->param["to"] = date($_SESSION["date"]["maskdate"]);
        $this->param["trace_import_from"] = date($_SESSION["date"]["maskdate"]);
        $this->param["trace_import_to"] = date($_SESSION["date"]["maskdate"]);
    }
}
