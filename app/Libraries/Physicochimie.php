<?php

namespace App\Libraries;

use App\Models\Physicochimie as ModelsPhysicochimie;
use App\Models\TraitClass;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;

class Physicochimie extends PpciLibrary
{
    public $keyName;
    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsPhysicochimie;
        $this->keyName = "trait_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }
    function change()
    {
        $this->vue = service('Smarty');
        /*
         * open the form to modify the record
         * If is a new record, generate a new record with default value :
         * $_REQUEST["idParent"] contains the identifiant of the parent record
         */
        $this->dataRead($this->id, "trait/physicochimieChange.tpl", $this->id);
        require_once "modules/classes/trait.class.php";
        $trait = new TraitClass();
        $this->vue->set($trait->getDetail($this->id), "trait");
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
