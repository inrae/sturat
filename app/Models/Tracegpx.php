<?php

namespace App\Models;

use Ppci\Libraries\PpciException;
use Ppci\Models\PpciModel;

/**
 * ORM of the table tracegpx
 */
class Tracegpx extends PpciModel
{
    public $ogr2ogr = "/usr/bin/ogr2ogr";
    public Traittrace $traittrace;
    /**
     * Constructor
     *
     * @param PDO $bdd
     * @param array $param
     */
    public function __construct()
    {
        $this->table = "tracegpx";
        $this->fields = array(
            "ogc_fid" => array("type" => 1, "key" => 1, "defaultValue" => 0, "requis" => 1),
            "filename" => array("type" => 0, "requis" => 1),
            "name" => array("type" => 0),
            "importdate" => array("type" => 3, "requis" => 1),
            "geom" => array("type" => 4)
        );
        parent::__construct();
    }
    /**
     * Import a gpx file with all traces
     *
     * @param string $filename
     * @param string $server
     * @param string $dbname
     * @param string $user
     * @param string $password
     * @return string|null
     */
    function importFileTrace(string $localfilename, string $filename, string $server, string $dbname, string $user, string $password): void
    {
        if (!is_file($localfilename)) {
            throw new PpciException(_("Le fichier à importer n'a pas été correctement téléchargé dans le serveur"));
        }
        $command = 'ogr2ogr -f PostgreSQL PG:"host="' . $server . '" dbname="' . $dbname . '" user="' . $user . '" password="' . $password . '" " -nln sturat.tracegpx -append -update ' . $localfilename . ' -lco geometry_name=geom -sql "Select name, ' . "'" . escapeshellcmd($filename) . "'" . ' as filename from tracks where name not like ' . "'COMMENTAIRE%'" . '"';
        system($command);
    }
    /**
     * Write the trace for the selected trait
     *
     * @param integer $trait_id
     * @param integer $ogc_fid
     * @return void
     */
    function setTrace(int $trait_id, int $ogc_fid)
    {
        $trace = $this->getTrace($ogc_fid);
        if (empty($trace["geom"])) {
            throw new PpciException(sprintf(_("La trace sélectionnée est vide pour le trait %s"), $trait_id));
        }
        if (!isset($this->traitTrace)) {
            $this->traittrace = new Traittrace;
        }
        $data = array("trait_id" => $trait_id, "trace_geom" => $trace["geom"]);
        $this->traittrace->write($data);
    }

    /**
     * Search a list of traces from date of importation
     *
     * @param array $data
     * @return array
     */
    function searchTrace(array $data): ?array
    {
        $sql = "select ogc_fid, filename, name, importdate,
            st_npoints(geom) as nb_points
            from tracegpx
            where importdate::date between :date_from: and :date_to:
            ";
        return $this->getListeParamAsPrepared(
            $sql,
            array(
                "date_from" => $this->formatDateLocaleVersDB($data["trace_import_from"]),
                "date_to" => $this->formatDateLocaleVersDB($data["trace_import_to"])
            )
        );
    }
    /**
     * Get the first linestring from the trace
     *
     * @param integer $ogc_fid
     * @return array
     */
    function getTrace(int $ogc_fid): array
    {
        $sql = "select st_astext(st_geometryn(geom, 1)) as geom from tracegpx where ogc_fid = :id:";
        return $this->lireParamAsPrepared($sql, array("id" => $ogc_fid));
    }
}
