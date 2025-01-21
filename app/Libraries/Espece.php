<?php

namespace App\Libraries;

use App\Models\Espece as ModelsEspece;
use App\Models\SearchEspece;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Espece extends PpciLibrary
{

    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsEspece();
        $this->keyName = "espece_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }
    function list()
    {
        $this->vue = service('Smarty');
        /*
		 * Display the list of all records of the table
		 */
        if (!isset($_SESSION["searchEspece"])) {
            $_SESSION["searchEspece"] = new SearchEspece;
        }
        $_SESSION["searchEspece"]->setParam($_REQUEST);
        $dataSearch = $_SESSION["searchEspece"]->getParam();
        if ($_SESSION["searchEspece"]->isSearch() == 1) {
            $this->vue->set($this->dataclass->getListFromParam($dataSearch), "data");
            $this->vue->set(1, "isSearch");
        }
        especeInitDropdownlist($this->dataclass, $dataSearch, $this->vue);
        $this->vue->set($dataSearch, "dataSearch");
        $this->vue->set("param/especeList.tpl", "corps");
        return $this->vue->send();
    }
    function change()
    {
        $this->vue = service('Smarty');
        /*
		 * open the form to modify the record
		 * If is a new record, generate a new record with default value :
		 * $_REQUEST["idParent"] contains the identifiant of the parent record
		 */
        $data = $this->dataRead($this->id, "param/especeChange.tpl");
        especeInitDropdownlist($this->dataclass, $data, $this->vue);
        return $this->vue->send();
    }
    function write()
    {
        try {
            $this->id = $this->dataWrite($_REQUEST);
            if ($this->id > 0) {
                $_REQUEST[$this->keyName] = $this->id;
                $_REQUEST["name"] = $_REQUEST["nom"];
                return $this->list();
            } else {
                return $this->change();
            }
        } catch (PpciException) {
            return $this->change();
        }
    }

    function delete()
    {
        /*
		 * delete record
		 */
        try {
            $this->dataDelete($this->id);
            return $this->list();
        } catch (PpciException $e) {
            return $this->change();
        }
    }
    function search()
    {
        $this->vue = service ("AjaxView");
        $this->vue->set($this->dataclass->getListFromName($_REQUEST["name"]));
        return $this->vue->send();
    }
    function getValues()
    {
        /*
		 * Retourne la liste des valeurs uniques du champ fourni en parametre,
		 * au format json
		 */
        $this->vue = service ("AjaxView");
        $this->vue->set($this->dataclass->getUniqueValuesFromParent($_REQUEST["field"], $_REQUEST["parentField"], $_REQUEST["value"]));
        return $this->vue->send();
    }
}
