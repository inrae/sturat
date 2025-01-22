<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\ReadOnlyLib;

class ReadOnlyControl extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new ReadOnlyLib();
    }
    function index()
    {
        $this->lib->index();
        defaultPage();
    }
}
