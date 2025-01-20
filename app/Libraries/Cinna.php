<?php 
namespace App\Libraries;

use App\Models\Cinna as ModelsCinna;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Cinna extends PpciLibrary { 

    
    private $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ModelsCinna();
        $this->keyName = "";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }

    function import() {
    $this->vue->set("cinna/cinnaImport.tpl", "corps");
    return $this->vue->send();
    }
    function importExec() {
    /**
     * Get the list of files downloaded
     */
    $files = formatFiles("cinnaFiles");
    $fileErrors = array(
      1 => _("La taille du fichier excède la valeur spécifiée dans les paramètres du serveur"),
      2 => _("La taille du fichier excède la valeur définie dans la page web"),
      3 => _("Le fichier n'a été que partiellement téléchargé"),
      4 => _("Le fichier n'a pas été téléchargé"),
      6 => _("Un dossier temporaire est manquant dans le serveur"),
      7 => ("Échec de l'écriture sur disque"),
      8 => _("Erreur inconnue")
    );
    /**
     * Connection to the database cinna
     */
    try {
      $cinnapdo = new PDO($cinnadb["dsn"], $cinnadb["login"], $cinnadb["password"]);
      $cinnapdo->exec("set search_path=" . $cinnadb["schema"]);
      $import = new Importgz();
      $cinna = new Cinna($cinnapdo);
      $units = array("K" => 7, "M" => 8, "N" => 9, "P" => 4, "B" => 3);
      $separator = ",";
      /**
       * Treatment of each file
       */
      foreach ($files as $file) {
        if ($file["error"] != 0) {
          throw new FileException(sprintf(_("Le fichier %1s n'a pas été téléchargé : %2s"), $file["name"], $fileErrors($file["error"])));
        }
        $min = 99999999;
        $max = 0;
        $cinnapdo->beginTransaction();
        $nblines = $import->initFile($file["tmp_name"], $separator);
        $cinnadata = $import->getData();
        $numline = 0;
        $latlonOK = false;
        $latlon = array();
        $geom = "";
        foreach ($cinnadata as $line) {
          $numline++;
          $line[1] = substr($line[1], 1);
          /**
           * Get the type of line
           */
          if ($line[1] == "INGGA") {
            /**
             * Position of the boat
             */
            $latlon = $cinna->getLatLonGGA($line);
            $latlonOK = $cinna->verifyLatLon($latlon);
            $geom = "POINT(" . $latlon["lon"] . " " . $latlon["lat"] . ")";
          } else {
            if ($latlonOK) {
              /**
               * Treatment of others lines
               */
              $lineOK = true;
              $data = array("cinna_id" => 0);
              switch ($line[1]) {
                  case "WIMW" :
                  /**
                   * Direction et force du vent
                   */
                  if ($line[3] == "T" && substr($line[6], 0, 1) == "A") {
                    /**
                     * Traitement uniquement de la force du vent ici
                     */
                    $data["val"] = $line[4];
                    $data["parameter_id"] = 7;
                    $data["unit_id"] = $units[$line[5]];
                  } else {
                    $lineOK = false;
                  }
                  break;
                  case "WIMTW" :
                  /**
                   * Temperature de l'eau
                   */
                  $data["val"] =  $line[2];
                  $data["parameter_id"] = 1;
                  $data["unit_id"] = 1;
                  break;
                  case "WIXDR" :
                  /**
                   * Capteurs meteo
                   */
                  $data["val"] = $line[3];
                  if ($line[2] == "C") {
                    /**
                     * Température de l'air
                     */
                    $data["unit_id"] = 1;
                    $data["parameter_id"] = 2;
                  } else if ($line[2] == "H") {
                    /**
                     * Humidité de l'air
                     */
                    $data["unit_id"] = 2;
                    $data["parameter_id"] = 3;
                  } else if ($line[2] == "P") {
                    /**
                     * Pression athmosphérique
                     */
                    $data["parameter_id"] = 4;
                    $data["unit_id"] = $units[$line[4]];
                  } else if ($line[2] == "J") {
                    /**
                     * Rayonnement solaire
                     */
                    $data["unit_id"] = 5;
                    $data["parameter_id"] = 5;
                  }
                  break;
                default:
                  $lineOK = false;
              }
              if ($lineOK) {
                $data["cinnadate"] = $cinna->formatDate($line[0]);
                $data["lon"] = $latlon["lon"];
                $data["lat"] = $latlon["lat"];
                $data["geom"] =  $geom;
                $this->id = $cinna->ecrire($data);
                if ($this->id < $min) {
                  $min = $this->id;
                }
                /**
                 * Ecriture en table
                 */
                /**
                 * Traitement de l'orientation du vent
                 */
                if ($line[1] == "WIMW") {
                  $data["val"] = $line[2];
                  $data["parameter_id"] = 6;
                  $data["unit_id"] = 6;
                  $this->id = $cinna->ecrire($data);
                }
                $max = $this->id;
              }
            }
          }
        }
        $this->message->set(sprintf(_("Fichier %1s traité. Id min généré : %2s, id max : %3s"), $file["name"], $min, $max));
        $cinnapdo->commit();
      }
      $module_coderetour = 1;
    } catch (Exception $e) {
      if ($cinnapdo->inTransaction()) {
        $cinnapdo->rollBack();
        $this->message->set(_("Echec de traitement du fichier"));
        $this->message->set(sprintf(_("Ligne potentiellement en erreur : %s"), $numline));
        $this->message->set(sprintf(_("Contenu de la ligne concernée : %s"), $line));
        $this->message->set($e->getMessage());
        $module_coderetour = -1;
      }
    }
    }
}
