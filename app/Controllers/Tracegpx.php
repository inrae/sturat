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
        if( $this->lib->importExec()) {
            return $this->pairing();
        } else {
            return $this->import();
        }
    }
    function pairing()
    {
        return $this->lib->pairing();
    }
    function pairingExec()
    {
        if ( $this->lib->pairingExec() ) {
            return defaultPage();
        } else {
            return $this->pairing();
        }
    }
}
