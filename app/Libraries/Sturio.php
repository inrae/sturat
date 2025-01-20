<?php

namespace App\Libraries;

use App\Models\Poisson;
use Ppci\Libraries\PpciLibrary;

class Sturio extends PpciLibrary
{
    private $keyName;
    function __construct()
    {
        parent::__construct();
        $this->dataclass = new IndividuSturio;
        $this->keyName = "individu_sturio_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }

    function list()
    {
        $this->vue = service('Smarty');
        /**
         * Display the list of traits
         */

        $_SESSION["searchSturio"]->setParam($_GET);
        $dataSearch = $_SESSION["searchSturio"]->getParam();
        if ($dataSearch["isSearch"] == 1) {
            $this->vue->set($this->dataclass->search($dataSearch["pittag"], $dataSearch["search_type"]), "data");
            $this->vue->set(1, "isSearch");
        }
        $this->vue->set($dataSearch, "dataSearch");
        $this->vue->set("sturio/sturioList.tpl", "corps");
        return $this->vue->send();
    }
    function detail()
    {
        $this->vue->set($this->dataclass->getSize($_GET["pittag"], $_GET["hp_tag"]), "measures");
        $this->vue->set($this->dataclass->getSampling($_GET["pittag"], $_GET["hp_tag"]), "samplings");
        $this->vue->set($this->dataclass->getListDetail($_GET["pittag"], $_GET["hp_tag"]), "sturios");
        if (!empty($_GET["pittag"])) {
            include_once "modules/classes/poisson.class.php";
            $poisson = new Poisson();
            $this->vue->set($poisson->getDetail($_GET["pittag"]), "poisson");
        }
        $this->vue->set("sturio/sturioDetail.tpl", "corps");
        return $this->vue->send();
    }
}
