<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Param as LibrariesParam;

class Param extends PpciController
{
    protected $lib;
    function list($table)
    {
        $this->initLibrary($table);
        return $this->lib->list();
    }
    function change($table)
    {
        $this->initLibrary($table);
        return $this->lib->change();
    }
    function write($table)
    {
        $this->initLibrary($table);
        if ($this->lib->write()) {
            return $this->lib->list();
        } else {
            return $this->lib->change();
        }
    }
    function delete($table)
    {
        $this->initLibrary($table);
        if ($this->lib->delete()) {
            return $this->lib->list();
        } else {
            return $this->lib->change();
        }
    }
    function initLibrary($table) {
        $this->lib = new LibrariesParam($table);
    }
}
