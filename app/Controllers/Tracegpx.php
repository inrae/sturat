<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Tracegpx as LibrariesTracegpx;

class Tracegpx extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesTracegpx();
    }
    function import()
    {
        return $this->lib->import();
    }
    function importExec()
    {
        return $this->lib->importExec();
    }
    function pairing()
    {
        return $this->lib->pairing();
    }
    function pairingExec()
    {
        return $this->lib->pairingExec();
    }
}
