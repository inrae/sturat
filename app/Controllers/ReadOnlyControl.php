<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\ReadOnlyClass;

class ReadOnlyControl extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new ReadOnlyClass();
    }
    function index()
    {
        return $this->lib->index();
    }
}
