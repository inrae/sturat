<?php

namespace App\Libraries;

use App\Models\SearchTrait;
use App\Models\Station;
use App\Models\Tracegpx as ModelsTracegpx;
use App\Models\TraitClass;
use Config\Database;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;
use \Safe\Exceptions\ExecException;

class Tracegpx extends PpciLibrary
{


    public $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsTracegpx;
        $this->keyName = "ogc_fid";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }

    function import()
    {
        $this->vue=service('Smarty');
        $this->vue->set("trait/traceImport.tpl", "corps");
        return $this->vue->send();
    }
    function importExec()
    {
        /**
         * Verify the upload of the file
         */
        if ($_FILES["upload"]["error"] != 0) {
            $this->message->set(_("Une erreur est survenue pendant le téléchargement du fichier"), true);
            $phpFileUploadErrors = array(
                1 => _('La taille du fichier dépasse la taille autorisée au niveau du serveur'),
                2 => _("La taille du fichier dépasse celle autorisée dans le formulaire"),
                3 => _("Le fichier n'a été chargé que partiellement"),
                4 => _("Le fichier n'a pas été téléchargé"),
                6 => _("Le dossier temporaire de dépôt du fichier n'existe pas dans le serveur"),
                7 => _("Une erreur est survenue pendant l'écriture sur le disque du serveur"),
                8 => _("Une extension de PHP a bloqué le téléchargement")
            );
            $this->message->set(_("Erreur rencontrée : ") . $phpFileUploadErrors["upload"]["error"], true);
        }
        try {
            /**
             * @var Database
             */
            $dbconfig = service("AppDatabase");
            $dbparam = $dbconfig->default;

            $this->dataclass->importFileTrace(
                $_FILES["upload"]["tmp_name"],
                $_FILES["upload"]["name"],
                $dbparam["hostname"],
                $dbparam["database"],
                $dbparam["username"],
                $dbparam["password"],
                $this->appConfig->ogr2ogr
            );
            return true;
        } catch (PpciException $e) {
            $this->message->set(_("Une erreur est survenue pendant l'écriture en base de données"), true);
            $this->message->set($e->getMessage());
            $this->message->setSyslog($e->getMessage());
            return false;
        }
    }
    function pairing()
    {
        $this->vue=service('Smarty');
        $this->vue->set("trait/tracePairing.tpl", "corps");
        if (!isset($_SESSION["searchTrait"])) {
            $_SESSION["searchTrait"] = new SearchTrait;
        }
        $_SESSION["searchTrait"]->setParam($_REQUEST);
        $dataSearch = $_SESSION["searchTrait"]->getParam();
        $traitClass = new TraitClass();
        $this->vue->set($traitClass->search($dataSearch), "traits");
        $this->vue->set($dataSearch, "dataSearch");
        $this->vue->set($this->dataclass->searchTrace($dataSearch), "traces");
        $station = new Station();
        $this->vue->set($station->getListe(1), "stations");
        return $this->vue->send();
    }
    function pairingExec()
    {
        $nb = 0;
        $db = $this->dataclass->db;
        $db->transBegin();
        try {
            foreach ($_POST as $key => $var) {
                if (substr($key, 0, 5) == "trait" && !empty($var)) {
                    $this->dataclass->setTrace(substr($key, 5), $var);
                    $nb++;
                }
            }
            $db->transCommit();
        } catch (PpciException $e) {
            $this->message->set(_("Une erreur a été rencontrée lors de l'appariement"), true);
            $this->message->set($e->getMessage());
            $this->message->setSyslog($e->getMessage());
            $nb = 0;
            if ($db->transEnabled) {
                $db->transRollback();
            }
        }
        if ($nb > 0) {
            $this->message->set(sprintf(_("%s traces(s) appariée(s)"), $nb));
            return true;
        } else {
            $this->message->set(_("Aucune trace n'a été appariée"), true);
            return false;
        }
    }
}
