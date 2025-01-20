<?php 
namespace App\Models;
use Ppci\Models\PpciModel;
class Maree extends PpciModel
{

  public function __construct()
  {
    $this->table = "maree";
    $this->fields = array(
      "maree_id" => array("type" => 1, "requis" => 1, "key" => 1, "defaultValue"=>0),
      "maree_libelle" => array("requis" => 1)
    );
    parent::__construct();
  }
}
