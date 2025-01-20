<?php

namespace App\Libraries;

use App\Models\Debris;
use App\Models\Echantillon;
use App\Models\Eel;
use App\Models\EnginType;
use App\Models\IndividuSturio;
use App\Models\Manipulateur;
use App\Models\Physicochimie;
use App\Models\SearchTrait;
use App\Models\Station;
use App\Models\TraitClass;
use App\Models\Traitdebris;
use App\Models\Traitgeom;
use App\Models\Traittrace;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;


class TraitLib extends PpciLibrary
{
	private $keyName;

	function __construct()
	{
		parent::__construct();
		$this->dataclass = new TraitClass;
		$this->keyName = "trait_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
	}
	function list()
	{
		$this->vue = service('Smarty');
		/**
		 * Display the list of traits
		 */
		if (!isset($_SESSION["searchTrait"])) {
			$_SESSION["searchTrait"] = new SearchTrait;
		}
		$_SESSION["searchTrait"]->setParam($_REQUEST);
		$dataSearch = $_SESSION["searchTrait"]->getParam();
		$data = $this->dataclass->search($dataSearch);
		$this->vue->set($data, "data");
		$this->vue->set($dataSearch, "dataSearch");
		$this->vue->set("trait/traitList.tpl", "corps");
		$station = new Station();
		$this->vue->set($station->getListe(1), "stations");
		return $this->vue->send();
	}
	function display()
	{
		$this->vue = service('Smarty');
		$this->vue->set($data = $this->dataclass->getDetail($this->id), "trait");
		$this->vue->set("trait/traitTab.tpl", "corps");
		$traitgeom = new Traitgeom();
		$this->vue->set($traitgeom->getDetail($this->id), "geom");
		$manipulateur = new Manipulateur();
		$this->vue->set($manipulateur->getListFromTrait($this->id), "manipulateurs");
		setParamMap($this->vue);
		$traittrace = new Traittrace();
		$this->vue->set($trace = $traittrace->getPoints($this->id), "trace");
		$phychim = new Physicochimie();
		$this->vue->set($pc = $phychim->lire($this->id), "phychim");
		$ech = new Echantillon();
		$this->vue->set($ech->getListFromTrait($this->id), "samples");
		$traitdebris = new Traitdebris();
		$this->vue->set($traitdebris->getListFromTrait($this->id), "traitdebris");
		$sturio = new IndividuSturio();
		$this->vue->set($sturio->getListFromTrait($this->id), "sturios");
		$eel = new Eel();
		$this->vue->set($eel->getListFromTrait($this->id), "eels");
		$station = new Station();
		$this->vue->htmlVars[] = "stationPoints";
		$this->vue->set(json_encode($station->getPoints($data["station_id"])), "stationPoints");
		if ($_SESSION["readOnly"] == 0 && $_SESSION["rights"]["manage"] == 1) {
			$debris = new Debris();
			$this->vue->set($debris->getListe("debris_name"), "debris");
		}
		return $this->vue->send();
	}
	function change()
	{
		$this->vue = service('Smarty');
		$data = $this->dataRead($this->id, "trait/traitChange.tpl");
		$traitgeom = new Traitgeom();
		foreach ($traitgeom->lire($this->id) as $field => $value) {
			$data[$field] = $value;
		}
		$this->vue->set($data, "data");
		$station = new Station();
		$this->vue->set($station->getListe(1), "stations");
		if ($this->id == 0) {
			$data["station_id"] = 1;
		}
		$this->vue->htmlVars[] = "stationPoints";
		$this->vue->set(json_encode($station->getPoints($data["station_id"])), "stationPoints");
		$manipulateur = new Manipulateur();
		$this->vue->set($manipulateur->getAllFromTrait($this->id), "manipulateurs");
		$engin = new EnginType();
		$this->vue->set($engin->getListe(2), "engins");
		setParamMap($this->vue);
		$traittrace = new Traittrace();
		$this->vue->set($trace = $traittrace->getPoints($this->id), "trace");
		return $this->vue->send();
	}
	function write()
	{
		try {
			$this->id = $this->dataWrite($_REQUEST);
			if ($this->id > 0) {
				$_REQUEST[$this->keyName] = $this->id;
				$traitgeom = new Traitgeom();
				$traitgeom->ecrire($_REQUEST);
				$this->dataclass->ecrireTableNN("trait_manipulateur", "trait_id", "manipulateur_id", $this->id, $_REQUEST["manipulateur"]);
				return $this->display();
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
		$db = $this->dataclass->db;
		$db->transBegin();
		try {
			$this->dataDelete($this->id, true);
			$db->transCommit();
			$this->message->set(_("Suppression effectuée"));
			unset($_REQUEST["trait_id"]);
			unset($_REQUEST["station_id"]);
			return true;
		} catch (PpciException $e) {
			if ($db->transEnabled) {
				$db->transRollback();
			}
			$this->message->set(_("Une erreur est survenue pendant la suppression"), true);
			$this->message->set($e->getMessage());
			$this->message->setSyslog($e->getMessage());
			return false;
		}
	}
}
