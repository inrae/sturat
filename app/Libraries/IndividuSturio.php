<?php

namespace App\Libraries;

use App\Models\IndividuSturio as ModelsIndividuSturio;
use App\Models\Nageoire;
use App\Models\Param;
use App\Models\Prelevement;
use App\Models\TraitClass;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class IndividuSturio extends PpciLibrary
{
    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsIndividuSturio;
        $this->keyName = "individu_sturio_id";
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
        $this->dataRead($this->id, "trait/traitSturioChange.tpl", $_REQUEST["trait_id"]);
        $trait = new TraitClass();
        $this->vue->set($trait->getDetail($_REQUEST["trait_id"]), "trait");
        if ($this->id > 0) {
            $prelevement = new Prelevement();
            $this->vue->set($prelevement->getListFromParent($this->id, "prelevement_id"), "prelevements");
        }
        /**
         * Get ref tables
         */
        $param = new Param("cohorte_determination");
        $this->vue->set($param->getListe(2), "cohortes");
        $param = new Param("prelevement_type");
        $this->vue->set($param->getListe(2), "preltypes");
        $param = new Param("prelevement_localisation");
        $this->vue->set($param->getListe(2), "localisations");
        $nageoire = new Nageoire();
        $this->vue->set($nageoire->getListe(2), "fins");
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
            $this->id = $this->dataWrite($_POST);
            if ($this->id > 0) {
                $_REQUEST[$this->keyName] = $this->id;
                /**
                 * update prelevement
                 */
                $prelevement = new Prelevement();
                $current = array();
                $oldPrelev = $prelevement->getListFromParent($this->id);
                foreach ($_POST as $name => $value) {
                    if (substr($name, 0, 11) == "prelevement") {
                        if (substr($name, 11, 3) == "new") {
                            $data = array("prelevement_id" => 0);
                            $new = "new";
                        } else {
                            $data = array("prelevement_id" => $value);
                            $new = "";
                            $current[] = $value;
                        }
                        $data["individu_sturio_id"] = $this->id;
                        $data["prelevement_type_id"] = $_POST["type" . $new . $value];
                        $data["prelevement_ref"] = $_POST["ref" . $new . $value];
                        $data["prelevement_localisation_id"] = $_POST["loc" . $new . $value];
                        $data["fin_id"] = $_POST["fin" . $new . $value];
                        $data["blood_quantity"] = $_POST["sang" . $new . $value];
                        $data["mucus_sampling"] = $_POST["mucus" . $new . $value];
                        $data["prelevement_comment"] = $_POST["comment" . $new . $value];
                        if (!empty($data["prelevement_type_id"])) {
                            $prelevement->ecrire($data);
                        }
                    }
                }
                /**
                 * Delete from old individus
                 */
                foreach ($oldPrelev as $row) {
                    if (!in_array($row["prelevement_id"], $current)) {
                        $prelevement->supprimer($row["prelevement_id"]);
                    }
                }
                $db->transCommit();
                $this->message->set(_("Esturgeon enregistré"));
                foreach ($this->dataclass->getErrorData() as $mess) {
                    $this->message->set($mess["message"], true);
                }
                return true;
            } else {
                throw new PpciException(_("Erreur indéterminée lors de l'enregistrement de l'esturgeon"));
            }
        } catch (PPciException $e) {
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
