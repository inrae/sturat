<?php

namespace App\Libraries;

use App\Models\Echantillon as ModelsEchantillon;
use App\Models\Individu;
use App\Models\TraitClass;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;

class Echantillon extends PpciLibrary
{
    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsEchantillon();
        $this->keyName = "echantillon_id";
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
        $this->dataRead($this->id, "trait/echantillonChange.tpl", $_REQUEST["trait_id"]);
        $trait = new TraitClass();
        $this->vue->set($trait->getDetail($_REQUEST["trait_id"]), "trait");
        if ($this->id > 0) {
            $individu = new Individu();
            $this->vue->set($individu->getListFromParent($this->id, "individu_id"), "individus");
        }
        return $this->vue->send();
    }
    function write()
    {

        /**
         * write record in database
         */
        $db = $this->dataclass->db;
        $db->transBegin();
        try {
            $this->id = $this->dataWrite($_POST, true);
            if ($this->id > 0) {
                $_REQUEST[$this->keyName] = $this->id;
                /**
                 * update individus
                 */
                $individu = new Individu();
                $current = array();
                $oldIndiv = $individu->getListFromParent($this->id);
                foreach ($_POST as $name => $value) {
                    if (substr($name, 0, 8) == "individu") {
                        if (substr($name, 8, 3) == "new") {
                            $data = array("individu_id" => 0);
                            $new = "new";
                        } else {
                            $data = array("individu_id" => $value);
                            $new = "";
                            $current[] = $value;
                        }
                        $data["echantillon_id"] = $this->id;
                        $data["fork_length"] = $_POST["fl" . $new . $value];
                        $data["total_length"] = $_POST["tl" . $new . $value];
                        $data["weight"] = $_POST["weight" . $new . $value];
                        if (!empty($data["fork_length"] || !empty($data["total_length"] || !empty($data["weight"])))) {
                            $individu->write($data);
                        }
                    }
                }
                /**
                 * Delete from old individus
                 */
                foreach ($oldIndiv as $row) {
                    if (!in_array($row["individu_id"], $current)) {
                        $individu->supprimer($row["individu_id"]);
                    }
                }
                $db->transCommit();
                $this->message->set(_("Échantillon enregistré"));
                return true;
            } else {
                throw new PpciException(_("Erreur indéterminée lors de l'enregistrement de l'échantillon"));
            }
        } catch (\Exception $e) {
            if ($db->transEnabled) {
                $db->transRollback();
            }
            $this->message->set(_("Une erreur est survenue pendant l'enregistrement"), true);
            $this->message->set($e->getMessage());
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
