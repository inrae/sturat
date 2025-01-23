<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Cinna as LibrariesCinna;
use Config\Database;

class Cinna extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesCinna();
    }
    function import()
    {
        return $this->lib->import();
    }
    function importExec()
    {
        /**
         * set the connection
         */
        /**
         * @var Database
         */
        $paramDb = config("Database");
        $db = db_connect("cinna");
        $db->query("set search_path = " . $paramDb->cinna["searchpath"]);
        $this->lib->importExec();
        return $this->import();
    }
}
