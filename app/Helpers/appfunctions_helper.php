<?php

/**
 * Transmet la liste des valeurs uniques des differents attributs des especes a Smarty
 *
 * @param Espece $espece
 */
function especeInitDropdownlist(\app\Models\Espece $espece, array $dataSearch, $vue)
{

    $vue->set($espece->getUniqueValues("auteur"), "auteur");
    $fields = array(
        "phylum",
        "subphylum",
        "classe",
        "ordre",
        "famille",
        "genre"
    );
    $parentField = "";
    $parentValue = "";
    foreach ($fields as $field) {
        if (!empty($parentField)) {
            /*
             * Recherche des infos liees a un parent
             */
            $vue->set($espece->getUniqueValuesFromParent($field, $parentField, $parentValue), $field);
        } else {
            $vue->set($espece->getUniqueValues($field), $field);
        }
        /*
         * Recherche si une selection a ete realisee sur le champ
         */
        if (!empty($dataSearch[$field])) {
            $parentField = $field;
            $parentValue = $dataSearch[$field];
        }
    }
}

if (!function_exists("generateSet")) {
    /**
     * Set all information for parameters tables in smarty view
     *
     * @param \Ppci\Libraries\Views\DefaultView $vue
     * @param string $tablename
     * @param string $description
     * @return void
     */
    function generateSet($vue, $tablename, $description)
    {
        $vue->set($tablename . "_id", "fieldid");
        $vue->set($tablename . "_name", "fieldname");
        $vue->set($tablename . "_code", "fieldcode");
        $vue->set($description, "tabledescription");
        $vue->set($tablename, "tablename");
    }
}

/**
 * Assign default values for maps
 *
 * @param \Ppci\Libraries\Views\DefaultView $vue
 * @return void
 */
function setParamMap($vue)
{
    if (isset($vue)) {
        foreach (
            array(
                "mapDefaultZoom",
                "mapDefaultLong",
                "mapDefaultLat",
                "mapCacheMaxAge",
                "mapMinZoom",
                "mapMaxZoom"
            ) as $mapParam
        ) {
            if (isset($_SESSION["dbparams"][$mapParam])) {
                $vue->set($_SESSION["dbparams"][$mapParam], $mapParam);
            }
        }
    }
}
/**
 * Fonction permettant de reorganiser les donnees des fichiers telecharges,
 * pour une utilisation directe en tableau
 * @return array
 */
function formatFiles($attributName = "documentName")
{
    global $_FILES;
    $files = array();
    $fdata = $_FILES[$attributName];
    if (is_array($fdata['name'])) {
        for ($i = 0; $i < count($fdata['name']); ++$i) {
            $files[] = array(
                'name' => $fdata['name'][$i],
                'type' => $fdata['type'][$i],
                'tmp_name' => $fdata['tmp_name'][$i],
                'error' => $fdata['error'][$i],
                'size' => $fdata['size'][$i]
            );
        }
    } else
        $files[] = $fdata;
    return $files;
}
