<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Traitdebris as LibrariesTraitdebris;

class Traitdebris extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesTraitdebris();
    }
    function write()
    {
        if ($this->lib->write()) {
            $traitControl = new TraitControl;
            return $traitControl->display();
        } else {
            $traitControl = new TraitControl;
            return $traitControl->display();
        }
    }
}
