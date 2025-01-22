<?php

namespace App\Libraries;

use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\Dbparam;

class ReadOnlyLib extends PpciLibrary
{
    function __construct()
    {
        $this->dataclass = new Dbparam;
    }

    function index()
    {

        try {
            if ($_POST["readOnly"] == 1 || $_POST["readOnly"] == 0) {
                $this->dataclass->setParameter("readOnly", $_POST["readOnly"]);
                if ($_POST["readOnly"] == 0) {
                    /**
                     * update the sequences
                     */
                    $this->updateSequences();
                }
                $_SESSION["readOnly"] = $_POST["readOnly"];
                return true;
            } else {
                throw new PpciException(_("Le paramètre readOnly n'est pas conforme à ce qui est attendu"));
            }
        } catch (PpciException $e) {
            $this->message->set(
                _("Problème rencontré lors de la lecture de la table des paramètres"),
                true
            );
            $this->message->setSyslog($e->getMessage());
            return false;
        }
    }
    function updateSequences()
    {
        $sequences = array(
            array("name" => "trait_trait_id_seq", "table" => "trait", "column" => "trait_id"),
            array("name" => "sonde_sonde_id_seq", "table" => "sonde", "column" => "sonde_id"),
            array("name" => "individu_individu_id_seq", "table" => "individu", "column" => "individu_id"),
            array("name" => "echantillon_echantillon_id_seq", "table" => "echantillon", "column" => "echantillon_id"),
            array("name" => "individu_sturio_individu_sturio_id_seq", "table" => "individu_sturio", "column" => "individu_sturio_id"),
            array("name" => "prelevement_prelevement_id_seq", "table" => "prelevement", "column" => "prelevement_id"),
            array("name" => "individu_eel_individu_eel_id_seq", "table" => "individu_eel", "column" => "individu_eel_id"),
            array("name" => "trait_debris_trait_debit_id_seq", "table" => "trait_debris", "column" => "trait_debit_id")
        );
        foreach ($sequences as $sequence) {
            $sql = "select setval('" . $sequence["name"] . "', (select max(" . $sequence["column"] . ") from " . $sequence["table"] . "))";
            $this->dataclass->executeSQL($sql, null, true);
        }
    }
}
