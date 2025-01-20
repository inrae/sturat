<?php

namespace App\Models;

/**
 * Parameters for searching sturios
 */
class SearchSturio extends SearchParam
{
    public function __construct()
    {
        $this->param = array(
            "search_type" => "pittag",
            "pittag" => ""
        );
        parent::__construct();
    }
}
