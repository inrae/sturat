<?php

namespace App\Libraries;

use App\Models\Traitdebris as ModelsTraitdebris;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;

class Traitdebris extends PpciLibrary
{


    private $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsTraitdebris;
        $this->keyName = "trait_debit_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }

    function write()
    {
        /**
         * write record in database
         */
        $oldDebris = $this->dataclass->getListFromTrait($_POST["trait_id"]);
        $db = $this->dataclass->db;
        $db->transBegin();
        try {
            $current = array();
            foreach ($_POST as $name => $value) {
                if (substr($name, 0, 2) == "td") {
                    if (substr($name, 2, 3) == "new") {
                        $data = array("trait_debit_id" => 0);
                        $new = "new";
                    } else {
                        $data = array("trait_debit_id" => $value);
                        $new = "";
                    }
                    $data["trait_id"] = $_POST["trait_id"];
                    $data["debris_id"] = $_POST["di" . $new . $value];
                    $data["debris_quantite"] = $_POST["dq" . $new . $value];
                    $data["weight"] = $_POST["weight" . $new . $value];
                    if ($data["debris_id"] > 0) {
                        if (empty($new)) {
                            $current[] = $value;
                        }
                        $this->dataclass->ecrire($data);
                    }
                }
            }
            /**
             * Delete from old debris
             */
            foreach ($oldDebris as $row) {
                if (!in_array($row["trait_debit_id"], $current)) {
                    $this->dataclass->supprimer($row["trait_debit_id"]);
                }
            }
            $db->transCommit();
            $this->message->set(_("Débris enregistrés"));
            return true;
        } catch (PpciException $e) {
            if ($db->transEnabled) {
                $db->transRollback();
            }
            $this->message->set(_("Une erreur est survenue pendant l'enregistrement"), true);
            $this->message->set($e->getMessage());
            return false;
        }
    }
}
