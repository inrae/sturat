<?php
namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\Cinna as LibrariesCinna;

class Cinna extends PpciController {
protected $lib;
function __construct() {
$this->lib = new LibrariesCinna();
}
function import() {
return $this->lib->import();
}
function importExec() {
return $this->lib->importExec();
}
}
