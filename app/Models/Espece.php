<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM of espece
 */
class Espece extends PpciModel
{
	private array $param = [];
	/**
	 * Constructor
	 *
	 */
	public function __construct()
	{
		$this->table = "espece";
		$this->fields = array(
			"espece_id" => array("type" => 1, "requis" => 1, "defaultValue" => 0, "key" => 1),
			"nom" => array("type" => 0, "requis" => 1),
			"nom_fr" => array("type" => 0),
			"auteur" => array("type" => 0),
			"phylum" => array("type" => 0),
			"subphylum" => array("type" => 0),
			"classe" => array("type" => 0),
			"ordre" => array("type" => 0),
			"famille" => array("type" => 0),
			"genre" => array("type" => 0),
			"code_perm_ifremer" => array("type" => 1),
			"code_sandre" => array("type" => 1)
		);
		parent::__construct();
	}
	function getListFromName($name)
	{
		$name = "%" . strtolower($name) . "%";
		$sql = "select espece_id, nom, nom_fr
          from espece
          where lower(nom) like :name: or lower(nom_fr) like :name1:";
		return $this->getListeParamAsPrepared($sql, array("name" => $name, "name1" => $name));
	}
	/**
	 * Fonction retournant les differentes valeurs uniques d'un champ,
	 * pour retrouver, par exemple, la liste des classes, ordres, etc.
	 *
	 * @param string $champ
	 * @return tableau
	 */
	function getUniqueValues($champ)
	{
		$field = pg_escape_identifier($this->db->getConnection(), $champ);
		if (strlen($champ) > 0 && array_key_exists($champ, $this->fields)) {
			$sql = "select distinct $field as field from espece order by $field";
			return $this->getListeParam($sql);
		}
	}
	/**
	 * Retourne la liste des valeurs d'un attribut rattaches a un autre attribut
	 * (subphylum attache a un phylum, par exemple)
	 *
	 * @param string $champ
	 *        	: colonne a rechercher
	 * @param string $champParent
	 *        	: colonne parente
	 * @param string $valeur
	 *        	: valeur parente
	 * @return array
	 */
	function getUniqueValuesFromParent($champ, $champParent, $valeur)
	{
		$field = pg_escape_identifier($this->db->getConnection(), $champ);
		$parentField = pg_escape_identifier($this->db->getConnection(),$champParent);
		if (!empty($champ) && array_key_exists($champ, $this->fields) && !empty($champParent) && array_key_exists($champParent, $this->fields) && !empty($valeur)) {
			$sql = "select distinct $field as field from espece
							where $parentField = :valeur:
							and $field is not null
							order by $field";
			return $this->getListeParam($sql,["valeur"=>$valeur]);
		}
	}
	/**
	 * Fonction recherchant les especes en fonction des parametres fournis
	 *
	 * @param array $param
	 * @return array
	 */
	function getListFromParam(array $param)
	{
		$sql = "select * from espece";
		$order = " order by nom";
		$where = $this->getWhere($param);
		return $this->getListeParam($sql . $where . $order, $this->param);
	}
	/**
	 * Genere la clause where a partir des parametres de recherche
	 * @param array $param
	 * @return string
	 */
	function getWhere($param)
	{
		$and = false;
		$where = " where ";
		if (strlen($param["nom"]) > 0) {
			if (is_numeric($param["nom"])) {
				$where .= " code_sandre = :sandre:";
				$this->param["sandre"] = $param["nom"];
			} else {
				$where .= "(upper(nom) like upper(:nom:)
					or upper(nom_fr) like upper(:nom_fr:))";
					$this->param["nom"] = "%" . $param["nom"] . "%";
					$this->param["nom_fr"] = "%" . $param["nom"] . "%";
			}
			$and = true;
		}
		$fields = array(
			"phylum",
			"subphylum",
			"classe",
			"ordre",
			"famille",
			"genre"
		);
		foreach ($fields as $field) {
			if (strlen($param[$field]) > 0) {
				$and ? $where .= " and " : $and = true;
				$where .= " $field = :$field:";
				$this->param[$field] = $param[$field];
			}
		}
		if (!$and) {
			$where = "";
		}
		return $where;
	}
}
