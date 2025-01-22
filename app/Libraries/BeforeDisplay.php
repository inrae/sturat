<?php 

namespace App\Libraries;

use Ppci\Libraries\PpciLibrary;
use Ppci\Libraries\Views\SmartyPpci;
use Ppci\Models\Dbparam;

class BeforeDisplay extends PpciLibrary
{
    static function index() {}
    static function setGeneric(SmartyPpci $vue) {
        if (!isset($_SESSION["readOnly"])) {
            $dbparam = new Dbparam;
            $_SESSION["readOnly"] = $dbparam->getParam("readOnly");
        }
        $vue->set($_SESSION["readOnly"], "readOnly");
    }
}
