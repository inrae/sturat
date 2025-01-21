<script>
    $(document).ready(function () {
        var readOnly = "{$readOnly}";
        if (readOnly == 1) {
            $(".field").prop("readonly", true);
        }
        /*
        * Rajout d'une ligne dans le tableau des individus
        */
        var numligne = 0;

        function addPrelevement() {
            if (readOnly == 0) {
                numligne++;
                var ligne = '<tr id="prelevementnew' + numligne + '">';
                ligne += '<td class="center"><input type="hidden" id="prelnew' + numligne + '" name="prelevementnew' + numligne + '" value="' + numligne + '"</td>';
                ligne += '<td ><select id="typenew' + numligne + '" name="typenew' + numligne + '" class="field form-control"> <option value="" selected>{t}Sélectionnez{/t}</option>';
                ligne += '{foreach $preltypes as $preltype}<option value="{$preltype.prelevement_type_id}">{$preltype.prelevement_type_name}</option>{/foreach}</select></td>';
                ligne += '<td><input class="form-control field" id="refnew' + numligne + '" name="refnew' + numligne + '" value=""></td>';
                ligne += '<td class="center"><select id="locnew' + numligne + '" name="locnew' + numligne + '" class="field form-control"><option value="" selected>{t}Sélectionnez{/t}</option>';
                ligne += '{foreach $localisations as $localisation}<option value="{$localisation.prelevement_localisation_id}">{$localisation.prelevement_localisation_name}</option>{/foreach}</select></td>';
                ligne += '<td class="center"><select id="finnew' + numligne + '" name="finnew' + numligne + '" class="field form-control"><option value="" selected>{t}Sélectionnez{/t}</option>';
                ligne += '{foreach $fins as $fin}<option value="{$fin.fin_id}"}>{$fin.fin_name}</option>{/foreach}</select></td>';
                ligne += '<td><input class="form-control taux field" id="sangnew' + numligne + '" name="sangnew' + numligne + '" value=""></td>';
                ligne += '<td><select id="mucusnew' + numligne + '" name="mucusnew' + numligne + '" class="form-control"><option value="" selected>{t}inconnu{/t}</option>';
                ligne += '<option value="1" >{t}oui{/t}</option><option value="0" >{t}non{/t}</option></select></td>';
                ligne += '<td><textarea class="form-control field" id="commentnew}" name="commentnew' + numligne + '"></textarea></td>';
                ligne += '<td class="center" id="deletePrelevement' + numligne + '" data-ligne="' + numligne + '"><img src="display/images/remove-red-24.png" height="25"></td>';
                ligne += '</tr>';
                $("#prelevements").last().append(ligne);

                /*
                * ajout de l'evenement click pour le bouton de suppression
                */
                $("#deletePrelevement" + numligne).on('click', function () {
                    var row = $(this).parent();
                    if (!row.is(':last-child')) {
                        $("#prelevementnew" + $(this).data("ligne")).remove();
                    }
                });
            }
        }
        $("#plus").on("click", function () {
            addPrelevement();
        });
        /*
        * Suppression des individus deja présents en base de données
        */
        $(".removePrelevement").click(function () {
            var row = $(this).parent();
            if (!row.is(':last-child')) {
                $("#prelevement" + $(this).data("ligne")).remove();
            }
        });

        /**
         * Ajout d'une ligne a l'ouverture du formulaire
         */
        if (readOnly == 0) {
            addPrelevement();
        }
        /**
         * mise à jour des tag
         */
        $(".tagupdate").change(function () {
            $("#"+$(this).data("name")).val($(this).val());
        });
    });
</script>
<h2>{t}Création/modification d'un esturgeon{/t}{if $data.individu_sturio_id > 0}&nbsp;{t}N°
    {/t}{$data.individu_sturio_id}{/if} - {t}trait n° {/t}&nbsp;{$trait.trait_id} -
    {t}Station{/t}&nbsp;{$trait.station_code} - &nbsp;{$trait.trait_start}</h2>
<div class="row">
    <a href="traitList">
        <img src="display/images/list.png" height="25">
        {t}Retour à la liste{/t}
    </a>
    &nbsp;
    <a href="traitDisplay?trait_id={$trait.trait_id}">
        <img src="display/images/display.png" height="25">
        {t}Retour au détail{/t}
    </a>
    {if $data.individu_sturio_id > 0 && $readOnly == 0}
    &nbsp;
    <a href="individuSturioChange?individu_sturio_id=0&trait_id={$trait.trait_id}">
        <img src="display/images/sturio.png" height="25">
        {t}Nouvel esturgeon{/t}
    </a>
    {/if}
</div>
<form class="form-horizontal" id="individuSturioForm" method="post" action="individuSturioWrite"
    enctype="multipart/form-data">
    <input type="hidden" name="moduleBase" value="individuSturio">
    <input type="hidden" name="trait_id" value="{$trait.trait_id}">
    <input type="hidden" name="individu_sturio_id" value="{$data.individu_sturio_id}">
    <div class="row">
        <div class="col-md-6">
            <fieldset>
                <legend>{t}Marques{/t}</legend>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th></th>
                            <th>{t}Lue{/t}</th>
                            <th>{t}Posée{/t}</th>
                            <th>{t}Marque{/t}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>{t}Pittag{/t}</td>
                            <td><input class="form-control tagupdate" data-name="pittag" id="pittag_read"
                                    name="pittag_read" value="{$data.pittag_read}"></td>
                            <td><input class="form-control tagupdate" data-name="pittag" id="implanted_pittag"
                                    name="implanted_pittag" value="{$data.implanted_pittag}"></td>
                            <td><input class="form-control" id="pittag" name="pittag"
                                    value="{$data.pittag}"></td>
                        </tr>
                        <tr>
                            <td>{t}HP tag{/t}</td>
                            <td><input class="form-control tagupdate" data-name="hp_tag" id="hp_tag_read"
                                    name="hp_tag_read" value="{$data.hp_tag_read}"></td>
                            <td><input class="form-control tagupdate" data-name="hp_tag" id="implanted_hp_tag"
                                    name="implanted_hp_tag" value="{$data.implanted_hp_tag}"></td>
                            <td><input class="form-control" id="hp_tag" name="hp_tag"
                                    value="{$data.hp_tag}"></td>
                        </tr>
                        <tr>
                            <td>{t}DST tag{/t}</td>
                            <td><input class="form-control tagupdate" data-name="dst_tag" id="dst_tag_read"
                                    name="dst_tag_read" value="{$data.dst_tag_read}"></td>
                            <td><input class="form-control tagupdate" data-name="dst_tag" id="implanted_dst_tag"
                                    name="implanted_dst_tag" value="{$data.implanted_dst_tag}"></td>
                            <td><input class="form-control" id="dst_tag" name="dst_tag"
                                    value="{$data.dst_tag}"></td>
                        </tr>
                    </tbody>
                </table>
            </fieldset>
            <fieldset>
                <legend>{t}Age{/t}</legend>
                <div class="form-group">
                    <label for="cohort" class="col-md-4 control-label">{t}Cohorte :{/t}</label>
                    <div class="col-md-8">
                        <input class="form-control field" id="cohort" name="cohort" value="{$data.cohort}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="age" class="col-md-4 control-label">{t}Age :{/t}</label>
                    <div class="col-md-8">
                        <input class="form-control nombre field" id="age" name="age" value="{$data.age}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="cohorte_determination_id" class="col-md-4 control-label">
                        {t}Méthode de détermination :{/t}</label>
                    <div class="col-md-8">
                        <select class="form-control field" id="cohorte_determination_id"
                            name="cohorte_determination_id">
                            <option value="" {if $data.cohorte_determination_id=="" }selected{/if}>{t}Sélectionnez{/t}
                            </option>
                            {foreach $cohortes as $cohorte}
                            <option value="{$cohorte.cohorte_determination_id}" {if
                                $data.cohorte_determination_id==$cohorte.cohorte_determination_id}selected{/if}>
                                {$cohorte.cohorte_determination_name}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="cohorte_determination_reliability" class="col-md-4 control-label">
                        {t}Fiabilité de la détermination :{/t}</label>
                    <div class="col-md-8">
                        <input class="form-control field" id="cohorte_determination_reliability"
                            name="cohorte_determination_reliability" value="{$data.cohorte_determination_reliability}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="release_age" class="col-md-4 control-label">{t}Age du lâcher :{/t}</label>
                    <div class="col-md-8">
                        <input class="form-control field" id="release_age" name="release_age"
                            value="{$data.release_age}">
                    </div>
                </div>
            </fieldset>
        </div>
        <div class="col-md-6">
            <fieldset>
                <legend>{t}Mensurations{/t}</legend>
                <div class="form-group">
                    <label for="fork_length" class="col-md-4 control-label">{t}Longueur fourche (cm) :{/t}</label>
                    <div class="col-md-8">
                        <input class="form-control taux field" id="fork_length" name="fork_length"
                            value="{$data.fork_length}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="total_length" class="col-md-4 control-label">{t}Longueur totale (cm) :{/t}</label>
                    <div class="col-md-8">
                        <input class="form-control taux field" id="total_length" name="total_length"
                            value="{$data.total_length}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="weight" class="col-md-4 control-label">{t}Masse (g) :{/t}</label>
                    <div class="col-md-8">
                        <input class="form-control taux field" id="weight" name="weight" value="{$data.weight}">
                    </div>
                </div>
            </fieldset>
            <fieldset>
                <legend>{t}État général{/t}</legend>
                <div class="form-group">
                    <label for="living" class="control-label col-md-4">{t}Vivant ?{/t}</label>
                    <div class="col-md-8">
                        <select id="living" name="living" class="form-control">
                            <option value="" {if $data.living=="" }selected{/if}>{t}inconnu{/t}</option>
                            <option value="1" {if $data.living==1}selected{/if}>{t}oui{/t}</option>
                            <option value="0" {if $data.living==0}selected{/if}>{t}non{/t}</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="parasite" class="control-label col-md-4">{t}Présence de parasites ?{/t}</label>
                    <div class="col-md-8">
                        <select id="parasite" name="parasite" class="form-control">
                            <option value="" {if $data.parasite=="" }selected{/if}>{t}inconnu{/t}</option>
                            <option value="1" {if $data.parasite==1}selected{/if}>{t}oui{/t}</option>
                            <option value="0" {if $data.parasite==0}selected{/if}>{t}non{/t}</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="capture_nb" class="col-md-4 control-label">{t}Nombre de captures :{/t}</label>
                    <div class="col-md-8">
                        <input class="form-control nombre field" id="capture_nb" name="capture_nb"
                            value="{$data.capture_nb}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="commentaire" class="col-md-4 control-label">{t}Commentaires :{/t}</label>
                    <div class="col-md-8">
                        <textarea class="form-control field" id="commentaire"
                            name="commentaire">{$data.commentaire}</textarea>
                    </div>
                </div>
            </fieldset>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <fieldset>
                <legend>
                    {t}Prélèvements{/t}
                </legend>
                {if $readOnly == 0}
                <span id="plus" onMouseOver="this.style.cursor='pointer'">
                    <img src="display/images/plus.png" height="25">&nbsp;{t}Ajouter une ligne{/t}
                </span>
                {/if}
                <table id="prelevements" class="table table-bordered table-hover ">
                    <thead>
                        <tr>
                            <th>{t}Id{/t}</th>
                            <th>{t}Type{/t}</th>
                            <th>{t}Référence{/t}</th>
                            <th>{t}Localisation{/t}</th>
                            <th>{t}Nageoire{/t}</th>
                            <th>{t}Qté sang{/t}</th>
                            <th>{t}Mucus{/t}</th>
                            <th>{t}Commentaire{/t}</th>
                            {if $readOnly == 0}
                            <th class="center"><img src="display/images/remove-red-24.png" height="25"></th>
                            {/if}
                        </tr>
                    </thead>
                    <tbody>
                        {foreach $prelevements as $prelevement}
                        <tr id="prelevement{$prelevement.prelevement_id}">
                            <td class="center">
                                {$prelevement.prelevement_id}
                                <input type="hidden" name="prelevement{$prelevement.prelevement_id}"
                                    value="{$prelevement.prelevement_id}">
                            </td>
                            <td class="center">
                                <select id="type{$prelevement.prelevement_id}" name="type{$prelevement.prelevement_id}"
                                    class="field form-control">
                                    <option value="">{t}Sélectionnez{/t}</option>
                                    {foreach $preltypes as $preltype}
                                    <option value="{$preltype.prelevement_type_id}" {if
                                        $prelevement.prelevement_type_id==$preltype.prelevement_type_id}selected{/if}>
                                        {$preltype.prelevement_type_name}</option>
                                    {/foreach}
                                </select>
                            </td>
                            <td>
                                <input class="form-control field" id="ref{$prelevement.prelevement_id}"
                                    name="ref{$prelevement.prelevement_id}" value="{$prelevement.prelevement_ref}">
                            </td>
                            <td class="center">
                                <select id="loc{$prelevement.prelevement_id}" name="loc{$prelevement.prelevement_id}"
                                    class="field form-control">
                                    <option value="">{t}Sélectionnez{/t}</option>
                                    {foreach $localisations as $localisation}
                                    <option value="{$localisation.prelevement_localisation_id}" {if
                                        $prelevement.prelevement_localisation_id==$localisation.prelevement_localisation_id}selected{/if}>
                                        {$localisation.prelevement_localisation_name}</option>
                                    {/foreach}
                                </select>
                            </td>
                            <td class="center">
                                <select id="fin{$prelevement.prelevement_id}" name="fin{$prelevement.prelevement_id}"
                                    class="field form-control">
                                    <option value="">{t}Sélectionnez{/t}</option>
                                    {foreach $fins as $fin}
                                    <option value="{$fin.fin_id}" {if $prelevement.fin_id==$fin.fin_id}selected{/if}>
                                        {$fin.fin_name}</option>
                                    {/foreach}
                                </select>
                            </td>
                            <td>
                                <input class="form-control taux field" id="sang{$prelevement.prelevement_id}"
                                    name="sang{$prelevement.prelevement_id}" value="{$prelevement.blood_quantity}">
                            </td>
                            <td>
                                <select id="mucus{$prelevement.prelevement_id}"
                                    name="mucus{$prelevement.prelevement_id}" class="form-control">
                                    <option value="" {if $prelevement.mucus_sampling=="" }selected{/if}>{t}inconnu{/t}
                                    </option>
                                    <option value="1" {if $prelevement.mucus_sampling}==1}selected{/if}>{t}oui{/t}
                                    </option>
                                    <option value="0" {if $prelevement.mucus_sampling}==0}selected{/if}>{t}non{/t}
                                    </option>
                                </select>
                            </td>
                            <td>
                                <textarea class="form-control field" id="comment{$prelevement.prelevement_id}"
                                    name="comment{$prelevement.prelevement_id}">{$prelevement.prelevement_comment}</textarea>
                            </td>
                            {if $readOnly == 0}
                            <td class="center removePrelevement" data-ligne="{$prelevement.prelevement_id}"><img
                                    src="display/images/remove-red-24.png" height="25"></td>
                            {/if}
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
            </fieldset>
        </div>
    </div>
    {if $readOnly == 0 && $rights.manage == 1}
    <div class="row">
        <div class="form-group center">
            <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
            {if $data.individu_sturio_id > 0 }
            <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
            {/if}
        </div>
    </div>
    {/if}
    {$csrf}
</form>