<?php
namespace App\Controllers;

use \Ppci\Controllers\PpciController;
use App\Libraries\ReadOnly as LibrariesReadOnly;

class ReadOnly extends PpciController {
protected $lib;
function __construct() {
$this->lib = new LibrariesReadOnly();
}
function index() {
return $this->lib->index();
}
}
