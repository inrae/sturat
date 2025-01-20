<?php

namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\IndividuEel as LibrariesIndividuEel;

class IndividuEel extends PpciController
{
    protected $lib;
    function __construct()
    {
        $this->lib = new LibrariesIndividuEel();
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
    function delete()
    {
        if ($this->lib->delete()) {
            $traitControl = new TraitControl;
            return $traitControl->display();
        } else {
            return $this->change();
        }
    }
}
