<?php 
namespace App\Models;
use Ppci\Models\PpciModel;

/**
 * Classe de base pour gerer des parametres de recherche
 * Classe non instanciable, a heriter
 * L'instance doit etre conservee en variable de session
 * @author Eric Quinton
 *
 */
class SearchParam
{

  /**
   * Tableau des parametres geres par la classe
   * La liste des parametres doit etre declaree dans la fonction construct
   *
   * @var array
   */
  public $param;

  public $paramNum;

  /**
   * Indique si la lecture des parametres a ete realisee au moins une fois
   * Permet ainsi de declencher ou non la recherche
   *
   * @var int
   */
  public $isSearch;

  /**
   * Constructeur de la classe
   * A rappeler systematiquement pour initialiser isSearch
   */
  public function __construct()
  {
    if (!is_array($this->param)) {
      $this->param = array();
    }
    $this->isSearch = 0;
    $this->param["isSearch"] = 0;
    if (is_array($this->paramNum)) {
      $this->paramNum = array_flip($this->paramNum);
    }
  }

  /**
   * Stocke les parametres fournis
   *
   * @param array $data
   *            : tableau des valeurs, ou non de la variable
   * @param string $valeur
   *            : valeur a renseigner, dans le cas ou la donnee est unique
   */
  function setParam($data, $valeur = NULL)
  {
    if (is_array($data)) {
      /**
       * Les donnees sont fournies sous forme de tableau
       */
      foreach ($this->param as $key => $value) {
        /**
         * Recherche si une valeur de $data correspond a un parametre
         */
        if (isset($data[$key])) {
          /**
           * Recherche si la valeur doit etre numerique
           */
          if (isset($this->paramNum[$key])) {
            if (!is_numeric($data[$key])) {
              $data[$key] = "";
            }
          }
          $this->param[$key] = $data[$key];
        }
      }
    } else {
      /**
       * Une donnee unique est fournie
       */
      if (isset($this->param[$data]) && !is_null($valeur)) {
        if (isset($this->paramNum[$data])) {
          if (!is_numeric($valeur)) {
            $valeur = "";
          }
        }
        $this->param[$data] = $valeur;
      }
    }
    /**
     * Gestion de l'indicateur de recherche
     */
    if ($data["isSearch"] == 1) {
      $this->isSearch = 1;
    }
  }

  /**
   * Retourne les parametres existants
   */
  function getParam()
  {
    return $this->param;
  }

  /**
   * Indique si la recherche a ete deja lancee
   *
   * @return int
   */
  function isSearch()
  {
    if ($this->isSearch == 1) {
      return 1;
    } else {
      return 0;
    }
  }

  /**
   * Encode les donnees avant de les envoyer au navigateur
   *
   * @param unknown $data
   * @return string|array
   */
  function encodeData($data)
  {
    if (is_array($data)) {
      foreach ($data as $key => $value) {
        $data[$key] = $this->encodeData($value);
      }
    } else {
      $data = htmlspecialchars($data);
    }
    return $data;
  }
  /**
   * Get the parameters in a JSON string
   *
   * @return string
   */
  function getParamAsJson()
  {
    return json_encode($this->param);
  }
  /**
   * Init the values with the content of a json string
   *
   * @param string $content
   * @return void
   */
  function setParamFromJson($content)
  {
    $this->setParam(json_decode($content, true));
  }

  /**
   * Function used to reinit some fields
   */
  function reinit()
  {
  }
}

/**
 * Exemple d'instanciation
 *
 * @author Eric Quinton
 *
 */
class SearchExample extends SearchParam
{

  public function __construct()
  {
    $this->param = array(
      "comment" => "",
      "numero" => 0,
      "numero1" => "",
      "dateExample" => date($_SESSION["MASKDATE"])
    );
    $this->paramNum = array(
      "numero",
      "numero1"
    );
    parent::__construct();
  }
}

/**
 * Parameters for searching traits
 *
 * @author quinton
 *
 */
class SearchTrait extends SearchParam
{
  public function __construct()
  {
    $this->param = array(
      "station_id" => "",
      "from" => "",
      "to" => "",
      "trait_id" => "",
      "trace_import_from" => "",
      "trace_import_to" => ""
    );
    /**
     * Ajout des dates
     */
    $this->reinit();
    $this->paramNum = array(
      "station_id"
    );
    parent::__construct();
  }
  function reinit()
  {
    $ds = new DateTime();
    $ds->modify("-1 month");
    $this->param["from"] = $ds->format($_SESSION["MASKDATE"]);
    $this->param["to"] = date($_SESSION["MASKDATE"]);
    $this->param["trace_import_from"] = date($_SESSION["MASKDATE"]);
    $this->param["trace_import_to"] = date($_SESSION["MASKDATE"]);

  }
}
/**
 * Parameters for searching sturios
 */
class SearchSturio extends SearchParam
{
  public function __construct()
  {
    $this->param = array(
      "search_type" => "pittag",
      "pittag" => ""
    );
    parent::__construct();
  }
}
/**
 * Classe de recherche des especes
 *
 * @author Eric Quinton
 *
 */
class SearchEspece extends SearchParam
{

    public function __construct()
    {
        $this->param = array(
            "nom" => "",
            "phylum" => "",
            "subphylum" => "",
            "classe" => "",
            "ordre" => "",
            "famille" => "",
            "genre" => ""
        );
        parent::__construct();
    }
}

