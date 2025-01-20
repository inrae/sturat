<?php 
namespace App\Models;
use Ppci\Models\PpciModel;

/**
 * ORM of manipulateur
 */
class Manipulateur extends PpciModel
{

  /**
   * Constructor
   *
   * @param PDO $bdd
   * @param array $param
   */
  public function __construct()
  {
    $this->table = "manipulateur";
    $this->fields = array(
      "manipulateur_id" => array("type" => 1, "requis" => 1, "key" => 1, "defaultValue" => 0),
      "name" => array("requis" => 1, "type" => 0),
      "firstname" => array("type" => 0),
      "actif" => array("type" => 1, "defaultValue" => 1)
    );
    parent::__construct();
  }

  /**
   * Get the list of manipulateurs attached to a trait
   *
   * @param integer $trait_id
   * @return void
   */
  function getListFromTrait(int $trait_id)
  {
    $sql = "select manipulateur_id, firstname, name, actif
          from manipulateur
          join trait_manipulateur using (manipulateur_id)
          where trait_id = :trait_id";
    return $this->getListeParamAsPrepared($sql, array("trait_id" => $trait_id));
  }

  /**
   * Get the list of manipulateurs with the indication of attachment to a trait (trait_id is not null)
   *
   * @param integer $trait_id
   * @return void
   */
  function getAllFromTrait(int $trait_id) {
    $sql = "select m.manipulateur_id, firstname, name, actif,
            trait_id
            from manipulateur m
            left outer join trait_manipulateur tm  on (tm.manipulateur_id = m.manipulateur_id and tm.trait_id = :trait_id)
            order by name, firstname
            ";
            return $this->getListeParamAsPrepared($sql, array("trait_id"=>$trait_id));
  }
}
