<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM of debris
 */
class Debris extends PpciModel
{

    private $sql = "select debris_id, debris_nature_id, unite_comptage, debris_name,
                  debris_nature_name
                  from debris
                  join debris_nature using (debris_nature_id)
                  ";

    public function __construct()
    {
        $this->table = "debris";
        $this->fields = array(
            "debris_id" => array("type" => 1, "requis" => 1, "defaultValue" => 0, "key" => 1),
            "debris_nature_id" => array("type" => 1, "requis" => 1),
            "unite_comptage" => array("type" => 0),
            "debris_name" => array("type" => 0, "requis" => 1)
        );
        parent::__construct();
    }
    /**
     * rewrite getListe to add the debris_nature_name
     *
     * @param string $order
     * @return array|null
     */
    function getListe($order = ""): array
    {
        if (!empty($order)) {
            $order = " order by $order";
        }
        return $this->getListeParam($this->sql . $order);
    }
}
