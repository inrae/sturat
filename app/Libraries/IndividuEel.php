<?php

namespace App\Libraries;

use App\Models\Eel;
use App\Models\TraitClass;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class IndividuEel extends PpciLibrary
{
    public $keyName;
    function __construct()
    {
        parent::__construct();
        $this->dataclass = new Eel();
        $this->keyName = "individu_eel_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }
    function change()
    {
        $this->vue = service('Smarty');
        $this->dataRead($this->id, "trait/traitEelChange.tpl", $_REQUEST["trait_id"]);
        $trait = new TraitClass();
        $this->vue->set($trait->getDetail($_REQUEST["trait_id"]), "trait");
        return $this->vue->send();
    }
    function write()
    {
        try {
            $this->id = $this->dataWrite($_REQUEST);
            if ($this->id > 0) {
                $_REQUEST[$this->keyName] = $this->id;
                return true;
            } else {
                return false;
            }
        } catch (PpciException) {
            return false;
        }
    }
    function delete()
    {
        /*
       * delete record
       */
        try {
            $this->dataDelete($this->id);
            return true;
        } catch (PpciException) {
            return false;
        }
    }
}
