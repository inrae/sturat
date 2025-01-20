<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * Extraction of informations on the fish during breeding
 */
class Poisson extends PpciModel
{
    /**
     * Constructor
     */
    public function __construct()

    {
        $this->table = "poisson";
        $this->fields = array(
            "date_naissance" => array("type" => 2),
            "morphologie_date" => array("type" => 2),
            "sortie_date" => array("type" => 2),

        );
        parent::__construct();
    }
    /**
     * Get general informations on the fish
     *
     * @param string $matricule
     * @return array|null
     */
    function getDetail(string $matricule): ?array
    {
        $sql = "SELECT matricule, prenom, date_naissance, cohorte, commentaire,
        peres, mere, pittag_valeur,
        sortie_date, localisation
        FROM poisson
        JOIN sortie USING (poisson_id)
        JOIN sortie_lieu USING (sortie_lieu_id)
        LEFT OUTER JOIN v_prenom_parents_male USING (poisson_id)
        LEFT OUTER JOIN v_prenom_parent_femelle USING (poisson_id)
        left outer join v_pittag_by_poisson vpbp using (poisson_id)
        WHERE matricule = :matricule:";
        return $this->lireParamAsPrepared($sql, array("matricule" => $matricule));
    }
}
