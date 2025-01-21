<?php

namespace App\Libraries;

use App\Models\IndividuSturio;
use App\Models\Poisson;
use App\Models\SearchSturio;
use Ppci\Libraries\PpciLibrary;

class Sturio extends PpciLibrary
{
    public $keyName;
    function __construct()
    {
        parent::__construct();
        $this->dataclass = new IndividuSturio;
        $this->keyName = "individu_sturio_id";
    }

    function list()
    {
        $this->vue = service('Smarty');
        /**
         * Display the list of traits
         */
        if (!isset($_SESSION["searchSturio"])) {
            $_SESSION["searchSturio"] = new SearchSturio;
        }
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
        $this->vue=service('Smarty');
        $this->vue->set($this->dataclass->getSize($_GET["pittag"], $_GET["hp_tag"]), "measures");
        $this->vue->set($this->dataclass->getSampling($_GET["pittag"], $_GET["hp_tag"]), "samplings");
        $this->vue->set($this->dataclass->getListDetail($_GET["pittag"], $_GET["hp_tag"]), "sturios");
        if (!empty($_GET["pittag"])) {
            $poisson = new Poisson;
            $this->vue->set($poisson->getDetail($_GET["pittag"]), "poisson");
        }
        $this->vue->set("sturio/sturioDetail.tpl", "corps");
        return $this->vue->send();
    }
}
