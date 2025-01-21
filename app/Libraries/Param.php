<?php

namespace App\Libraries;

use App\Models\Param as ModelsParam;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Param extends PpciLibrary
{


	public $keyName;
	private $tablename;
	private $tableDescriptions = [];

	function __construct($tablename)
	{
		parent::__construct();
		$this->tablename = $tablename;
		$this->dataclass = new ModelsParam($tablename);
		$this->keyName = $tablename . "_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
		$this->tableDescriptions = [
			"debris_nature" => _("Natures des débris"),
			"prelevement_localisation" => _("Localisation du prélèvement"),
			"prelevement_type" => _("Type de prélèvement"),
			"cohorte_determination" => _("Méthodes de détermination des cohortes"),
			"eel_stade" => _("Stades de l'anguille"),
			"release_stage" => _("Stades de lâcher")
		];
	}
	function list()
	{
		$this->vue = service('Smarty');
		$this->vue->set($data = $this->dataclass->getListe(1), "data");
		$this->vue->set("param/paramList.tpl", "corps");
		generateSet($this->vue, $this->tablename, $this->tableDescriptions[$this->tablename]);
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
		$this->dataRead($this->id, "param/paramChange.tpl");
		generateSet($this->vue, $this->tablename, $this->tableDescriptions[$this->tablename]);
		return $this->vue->send();
	}
	function write()
	{
		try {
			$this->id = $this->dataWrite($_REQUEST);
			if ($this->id > 0) {
				$_REQUEST[$this->keyName] = $this->id;
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
}
