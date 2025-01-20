<?php 
namespace App\Libraries;
use Ppci\Libraries\PpciLibrary;
class PostLogin extends PpciLibrary {
    static function index() {
        if (!$_SESSION["rights"]["manage"] == 1) {
            $_SESSION["readOnly"] = 1;
        }
    }
}