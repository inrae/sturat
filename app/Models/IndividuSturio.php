<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de individu_sturio
 */
class IndividuSturio extends PpciModel
{

    /**
     * Constructor
     *
     * @param PDO $bdd
     * @param array $param
     */
    public function __construct()
    {
        $this->table = "individu_sturio";
        $this->fields = array(
            "individu_sturio_id" => array("type" => 1, "key" => 1, "defaultValue" => 0, "requis" => 1),
            "trait_id" => array("type" => 1, "requis" => 1, "parentAttrib" => 1),
            "pittag" => array("type" => 0),
            "hp_tag" => array("type" => 0),
            "implanted_hp_tag" => array("type" => 0),
            "dst_tag" => array("type" => 0),
            "implanted_dst_tag" => array("type" => 0),
            "age" => array("type" => 1),
            "cohort" => array("type" => 0),
            "cohorte_determination_id" => array("type" => 1),
            "commentaire" => array("type" => 0),
            "living" => array("type" => 1),
            "capture_nb" => array("type" => 1),
            "state" => array("type" => 0),
            "parent" => array("type" => 1),
            "tetracycline_treatment" => array("type" => 1),
            "campaign_date" => array("type" => 2),
            "campaign_name" => array("type" => 0),
            "cohorte_determination_reliability" => array("type" => 0),
            "fork_length" => array("type" => 1),
            "parasite" => array("type" => 1),
            "total_length" => array("type" => 1),
            "weight" => array("type" => 1),
            "implanted_pittag" => array("type" => 0),
            "pittag_read" => array("type" => 0),
            "release_age" => array("type" => 0),
            "hp_tag_read" => array("type" => 0),
            "dst_tag_read" => array("type" => 0),
            "release_stage_id" => array("type" => 1),
            "sortie_lieu_id" => array("type" => 1),
            "father_id" => array("type" => 1),
            "mother_id" => array("type" => 1)

        );
        parent::__construct();
    }

    /**
     * Simplified list of sturio sampling into a trait
     *
     * @param integer $trait_id
     * @return array|null
     */
    function getListFromTrait(int $trait_id): ?array
    {
        $sql = "select individu_sturio_id, trait_id, pittag, hp_tag, dst_tag,
            total_length, fork_length, weight, cohort
            from individu_sturio
            where trait_id = :trait_id:";
        return $this->getListeParamAsPrepared($sql, array("trait_id" => $trait_id));
    }
    /**
     * Search all fishes captured or released
     *
     * @param string $tag
     * @param string $searchType
     * @return array|null
     */
    function search(string $tag, string $searchType = "pittag"): ?array
    {
        if ($searchType == "pittag") {
            $sql = "with req as (
        select null::int as individu_sturio_id
        ,matricule as pittag, sortie_date as poisson_date, localisation, 'lâcher' as poisson_type
        ,null as hp_tag, null as dst_tag, cohorte
        ,longueur_totale as total_length, longueur_fourche as fork_length, masse as weight
        from poisson
        join sortie using (poisson_id)
        join sortie_lieu using (sortie_lieu_id)
        left outer join v_poisson_last_lf using (poisson_id)
        left outer join v_poisson_last_lt using (poisson_id)
        left outer join v_poisson_last_masse using (poisson_id)
        where poisson.poisson_statut_id = 4 and matricule like :tag:
        union
        select individu_sturio_id
        ,pittag, trait_start as poisson_date, station_code as localisation, 'capture' as poisson_type,
        hp_tag, dst_tag, cohort as cohorte
        ,total_length, fork_length, weight
        from sturat.individu_sturio is2
        join sturat.trait using (trait_id)
        join sturat.station using (station_id)
        where pittag like :tag:
        )
        select distinct pittag, poisson_date, localisation, poisson_type, hp_tag, dst_tag, cohorte,
        total_length, fork_length, weight
        from req";
        } else {
            $searchType == "hp_tag" ? $field = "hp_tag" : $field = "dst_tag";
            $sql = "with req1 as (
        select  individu_sturio_id
                ,pittag, trait_start as poisson_date, station_code as localisation, 'capture' as poisson_type
                ,hp_tag, dst_tag, cohort as cohorte
                ,total_length, fork_length, weight
                from sturat.individu_sturio is2
                join sturat.trait using (trait_id)
                join sturat.station using (station_id)
                where $field like :tag:
                ),
                req2 as (
                select distinct on (matricule) null::int as individu_sturio_id
                ,matricule as pittag, sortie_date as poisson_date, sortie_lieu.localisation, 'lâcher' as poisson_type
                ,null as hp_tag, null as dst_tag, poisson.cohorte
                ,longueur_totale as total_length, longueur_fourche as fork_length, masse as weight
                from poisson
                join sortie using (poisson_id)
                join sortie_lieu using (sortie_lieu_id)
                join req1 on (matricule = pittag)
                left outer join v_poisson_last_lf using (poisson_id)
                left outer join v_poisson_last_lt using (poisson_id)
                left outer join v_poisson_last_masse using (poisson_id)
                where poisson.poisson_statut_id = 4
                ),
                req3 as (
                select is2.individu_sturio_id
                ,is2.pittag, trait_start as poisson_date, station_code as localisation, 'capture' as poisson_type
                ,is2.hp_tag, is2.dst_tag, cohort as cohorte
                ,is2.total_length, is2.fork_length, is2.weight
                from sturat.individu_sturio is2
                join sturat.trait using (trait_id)
                join sturat.station using (station_id)
                join req1 on (req1.pittag = is2.pittag and req1.poisson_date <> trait_start)
                )
                select distinct * from req1 union select * from req2 union select * from req3
                ";
        }
        $this->dateFields[] = "poisson_date";
        $this->dateFields[] = "trait_start";

        return $this->getListeParamAsPrepared($sql, array("tag" => '%' . $tag . '%'));
    }

    /**
     * Get list of measures from breeding or catch, searched by pittag or hptag
     *
     * @param string $pittag
     * @param string $hptag
     * @return array|null
     */
    function getSize(string $pittag, string $hptag = ""): ?array
    {
        $sql = "select longueur_fourche as fork_length, longueur_totale as total_length, masse as weight, morphologie_date as measure_date
    ,'élevage' as measure_type
    from morphologie m
    join poisson using (poisson_id)
    where matricule = :pittag:
    union
    select fork_length, total_length, weight, trait_start as measure_date
    , 'capture' as measure_type
    from sturat.individu_sturio is2
    join sturat.trait using (trait_id)
    where pittag = :pittag:";
        $search = array("pittag" => $pittag);
        if (!empty($hptag)) {
            $sql .= " or hp_tag = :hptag:";
            $search["hptag"] = $hptag;
        }
        $this->dateFields[] = "measure_date";
        return $this->getListeParamAsPrepared($sql, $search);
    }
    /**
     * Get list of samplings from pittag or hptag
     *
     * @param string $pittag
     * @param string $hptag
     * @return array|null
     */
    function getSampling(string $pittag, string $hptag = ""): ?array
    {
        $sql = "select trait_start, fin_name, prelevement_ref, prelevement_comment,blood_quantity, mucus_sampling
    ,prelevement_localisation_name, prelevement_type_name
    from sturat.prelevement p
    join sturat.individu_sturio is2 using (individu_sturio_id)
    join sturat.trait using (trait_id)
    join sturat.prelevement_type pt using (prelevement_type_id)
    left outer join sturat.nageoire using (fin_id)
    left outer join sturat.prelevement_localisation pl using (prelevement_localisation_id)
    where pittag = :pittag:";
        $search = array("pittag" => $pittag);
        if (!empty($hptag)) {
            $sql .= " or hp_tag = :hptag:";
            $search["hptag"] = $hptag;
        }
        $this->dateFields[] = "trait_start";
        return $this->getListeParamAsPrepared($sql, $search);
    }
    /**
     * Get the detail of each catch for a fish
     *
     * @param string $pittag
     * @param string $hptag
     * @return array|null
     */
    function getListDetail(string $pittag, string $hptag = ""): ?array
    {
        $sql = "select pittag, hp_tag, dst_tag
    ,implanted_pittag, implanted_hp_tag, implanted_dst_tag
    ,age, cohort, is2.commentaire
    ,trait_start, station_code
    ,fork_length, total_length, weight
    ,tetracycline_treatment, parasite
    ,pere.matricule as father, mere.matricule as mother
    ,pere.prenom as father_firstname, mere.prenom as mother_firstname
    from sturat.individu_sturio is2
    join sturat.trait using (trait_id)
    join sturat.station s using (station_id)
    left outer join poisson pere on (father_id = pere.poisson_id)
    left outer join poisson mere on (mother_id = mere.poisson_id)
    where pittag = :pittag:";
        $search = array("pittag" => $pittag);
        if (!empty($hptag)) {
            $sql .= " or hp_tag = :hptag:";
            $search["hptag"] = $hptag;
        }
        $this->fields[] = "trait_start";
        return $this->getListeParamAsPrepared($sql, $search);
    }
    /**
     * add the deletion of the attached prelevements
     *
     * @param int $id
     * @return int
     */
    function supprimer($id)
    {
        $prelev = new Prelevement;
        $prelev->supprimerChamp($id, "individu_sturio_id");
        return parent::supprimer($id);
    }
}
