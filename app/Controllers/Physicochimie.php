<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Physicochimie as LibrariesPhysicochimie;

class Physicochimie extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesPhysicochimie();
    }
    function change()
    {
        return $this->lib->change();
    }
    function write()
    {
        if ($this->lib->write()) {
            $traitControl = new TraitControl;
            return $traitControl->display();
        } else {
            return $this->change();
        }
    }
}
