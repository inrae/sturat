<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Sturio as LibrariesSturio;

class Sturio extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesSturio();
    }
    function list()
    {
        return $this->lib->list();
    }
    function detail()
    {
        return $this->lib->detail();
    }
}
