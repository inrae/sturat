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
        var nbMesure = "{$data.total_measured_number}";

        function addIndiv() {
            if (readOnly == 0) {
                numligne++;
                var ligne = '<tr id="individunew' + numligne + '">';
                ligne += '<td class="center"><input type="hidden" id="indiv' + numligne + '" name="individunew' + numligne + '" value="' + numligne + '"></td>';
                ligne += '<td class="center"><input id="fl' + numligne + '" class="taux" name="flnew' + numligne + '">';
                ligne += '</td><td class="center">';
                ligne += '<input id="tl' + numligne + '" class="taux" name="tlnew' + numligne + '">';
                ligne += '</td><td class="center">';
                ligne += '<input id="weight' + numligne + '" class="taux" name="weightnew' + numligne + '"></td>';
                ligne += '<td class="center" id="deleteIndiv' + numligne + '" data-ligne="' + numligne + '"><img src="display/images/remove-red-24.png" height="25"></td>';
                ligne += '</tr>';
                $("#individus").last().append(ligne);

                /*
                * ajout de l'evenement click pour le bouton de suppression
                */
                $("#deleteIndiv" + numligne).bind('click', function () {
                    var row = $(this).parent();
                    if (!row.is(':last-child')) {
                        $("#individunew" + $(this).data("ligne")).remove();
                        nbMesure--;
                        $("#total_measured_number").val(nbMesure);
                    }
                });
                $("#individunew" + numligne + " td").keypress(function (e) {
                    individuOnKeyPress(this);
                });
            }
        }
        /**
        * Verification de la saisie de l'espece avant envoi du formulaire
        */
        $("#echantillonForm").submit(function (event) {
            var espece = $("#espece_id").val();
            if (!espece > 0) {
                event.preventDefault();
            };
        });
        /*
        * Suppression des individus deja présents en base de données
        */
        $(".removeIndiv").click(function () {
            var row = $(this).parent();
            if (!row.is(':last-child')) {
                $("#individu" + $(this).data("ligne")).remove();
                nbMesure--;
                $("#total_measured_number").val(nbMesure);
            }
        });
        $("#recherche").keyup(function () {
            /*
            * Traitement de la recherche d'une espèce
            */
            var texte = $(this).val();
            if (texte.length > 2) {
                /*
                * declenchement de la recherche
                */
                var url = "especeSearchAjax";
                $.getJSON(url, { "name": texte }, function (data) {
                    var options = '';
                    for (var i = 0; i < data.length; i++) {
                        options += '<option value="' + data[i].espece_id + '"';
                        if (i == 0) {
                            options += " selected";
                        }
                        options += '>' + data[i].nom + " " + data[i].nom_fr + '</option>';
                    };
                    $("#espece_id").html(options);
                });
            };
        });
        /**
         * Ajout d'une ligne automatique dans le tableau
         */
        function individuOnKeyPress(elem) {
            var row = $(elem).parent();
            if (row.is(':last-child')) {
                nbMesure++;
                $("#total_measured_number").val(nbMesure);
                var total = $("#total_number").val();
                if (isNaN(total)) {
                    total = 0;
                }
                if (total < nbMesure) {
                    $("#total_number").val(nbMesure);
                }
                addIndiv();
            }
        }
        /**
         * Ajout d'une ligne a l'ouverture du formulaire
         */
        if (readOnly == 0) {
            addIndiv();
        }
    });
</script>
<h2>{t}Création/modification d'un échantillon - trait n° {/t}&nbsp;{$trait.trait_id} -
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
</div>
<form class="form-horizontal" id="echantillonForm" method="post" action="echantillonWrite">
    <input type="hidden" name="moduleBase" value="echantillon">
    <input type="hidden" name="trait_id" value="{$trait.trait_id}">
    <input type="hidden" name="echantillon_id" value="{$data.echantillon_id}">
    <div class="row">
        <fieldset class="col-md-4">
            <legend>{t}Description de l'échantillon{/t}{if $data.echantillon_id > 0}&nbsp;{$data.echantillon_id}{/if}
            </legend>
            <div class="form-group">
                <label for="recherche" class="control-label col-md-4">{t}Espèce :{/t}</label>
                <div class="col-md-8">
                    {if $readOnly == 0}
                    <input class="form-control" id="recherche" autocomplete="off" autofocus
                        placeholder="{t}espèce à chercher{/t}" title="{t}Tapez au moins 3 caractères...{/t}">
                    {/if}
                    <select name="espece_id" id="espece_id" class="form-control">
                        {if $data.espece_id > 0}
                        <option value="{$data.espece_id}" selected>{$data.nom_fr} {$data.nom}</option>
                        {/if}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="total_number" class="col-md-4 control-label">{t}Nombre total :{/t}</label>
                <div class="col-md-8">
                    <input class="form-control nombre field" id="total_number" name="total_number"
                        value="{$data.total_number}">
                </div>
            </div>
            <div class="form-group">
                <label for="total_measured_number" class="col-md-4 control-label">{t}Dont mesurés :{/t}</label>
                <div class="col-md-8">
                    <input class="form-control nombre field" id="total_measured_number" name="total_measured_number"
                        value="{$data.total_measured_number}">
                </div>
            </div>
            <div class="form-group">
                <label for="total_death" class="col-md-4 control-label">{t}Dont morts :{/t}</label>
                <div class="col-md-8">
                    <input class="form-control nombre field" id="total_death" name="total_death"
                        value="{$data.total_death}">
                </div>
            </div>
            <div class="form-group">
                <label for="total_sample" class="col-md-4 control-label">
                    {t}Dont conservés pour d'autres expérimentations :{/t}</label>
                <div class="col-md-8">
                    <input class="form-control nombre field" id="total_sample" name="total_sample"
                        value="{$data.total_sample}">
                </div>
            </div>
            <div class="form-group">
                <label for="sample_comment" class="col-md-4 control-label">
                    {t}Destination des poissons conservés :{/t}</label>
                <div class="col-md-8">
                    <textarea class="form-control field" id="sample_comment"
                        name="sample_comment">{$data.sample_comment}</textarea>
                </div>
            </div>
            <div class="form-group">
                <label for="weight" class="col-md-4 control-label">{t}Masse (g) :{/t}</label>
                <div class="col-md-8">
                    <input class="form-control taux field" id="weight" name="weight" value="{$data.weight}">
                </div>
            </div>
            <div class="form-group">
                <label for="weight_comment" class="col-md-4 control-label">{t}Commentaires sur la masse :{/t}</label>
                <div class="col-md-8">
                    <textarea class="form-control field" id="weight_comment"
                        name="weight_comment">{$data.weight_comment}</textarea>
                </div>
            </div>
        </fieldset>

        <!-- Liste des individus-->
        <fieldset class="col-md-8">
            <legend>{t}Individus mesurés{/t}</legend>
            <table id="individus" class="table table-bordered table-hover ">
                <thead>
                    <tr>
                        <th>{t}Id{/t}</th>
                        <th>{t}Longueur fourche (cm){/t}</th>
                        <th>{t}Longueur totale (cm){/t}</th>
                        <th>{t}Masse (g){/t}</th>
                        {if $readOnly == 0}
                        <th class="center"><img src="display/images/remove-red-24.png" height="25"></th>
                        {/if}
                    </tr>
                </thead>
                <tbody>
                    {foreach $individus as $individu}
                    <tr id="individu{$individu.individu_id}">
                        <td class="center">
                            {$individu.individu_id}
                            <input type="hidden" name="individu{$individu.individu_id}" value="{$individu.individu_id}">
                        </td>
                        <td class="center">
                            <input id="fl{$individu.individu_id}" name="fl{$individu.individu_id}" class="field taux"
                                value="{$individu.fork_length}">
                        </td>
                        <td class="center">
                            <input id="tl{$individu.individu_id}" name="tl{$individu.individu_id}" class="field taux"
                                value="{$individu.total_length}">
                        </td>
                        <td class="center">
                            <input id="weight{$individu.individu_id}" name="weight{$individu.individu_id}"
                                class="field taux" value="{$individu.individu_masse}">
                        </td>
                        {if $readOnly == 0}
                        <td class="center removeIndiv" data-ligne="{$individu.individu_id}"><img
                                src="display/images/remove-red-24.png" height="25"></td>
                        {/if}
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </fieldset>
    </div>
    {if $readOnly == 0 && $rights.manage == 1}
    <div class="row">
        <div class="form-group center">
            <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
            {if $data.echantillon_id > 0 }
            <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
            {/if}
        </div>
        {/if}

    </div>
</form>