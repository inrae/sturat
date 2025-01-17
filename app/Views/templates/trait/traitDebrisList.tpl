<script>
    $(document).ready(function () {
        var gestion = "{$rights.manage}";
        var readOnly = "{$readOnly}";
        var numligne = 0;
        function addDebris() {
            if (readOnly == 0) {
                numligne++;
                var ligne = '<tr id="debrisnew' + numligne + '">';
                ligne += '<td class="center"><input type="hidden" id="td' + numligne + '" name="tdnew' + numligne + '" value="' + numligne + '"></td>';
                ligne += '<td ><select class="form-control debris_id" id="dinew' + numligne + '" name="dinew' + numligne + '">';
                ligne += '<option value="0" selected>{t}Sélectionnez{/t}</option>';
                {foreach $debris as $deb}
                ligne += '<option value="{$deb.debris_id}">{$deb.debris_name} ({$deb.unite_comptage})</option>';
                {/foreach}
                ligne += '</select></td>';
                ligne += '<td><input class="form-control" id="dqnew' + numligne + '" name="dqnew' + numligne + '"></td>';
                ligne += '<td class="center" id="deleteDebris' + numligne + '" data-ligne="' + numligne + '"><img src="display/images/remove-red-24.png" height="25"></td>';
                ligne += '</tr>';
                $("#traitDebrisList").last().append(ligne);

                /*
                * ajout de l'evenement click pour le bouton de suppression
                */
                $("#deleteDebris" + numligne).bind('click', function () {
                    var row = $(this).parent();
                    if (!row.is(':last-child')) {
                        $("#debrisnew" + $(this).data("ligne")).remove();
                    }
                });
                $("#debrisnew" + numligne + " td").keypress(function (e) {
                    debrisOnKeyPress(this);
                });
                $("#dinew" + numligne).change(function () {
                    debrisOnKeyPress(this);
                });
            }
        }
        /*
        * Suppression des individus deja présents en base de données
        */
        $(".removeDebris").click(function () {
            var row = $(this).parent();
            if (!row.is(':last-child')) {
                $("#debris" + $(this).data("ligne")).remove();
            }
        });
        function debrisOnKeyPress(elem) {
            var row = $(elem).parent();
            if (row.is(':last-child')) {
                addDebris();
            }
        }
        if (readOnly == 1 || gestion != 1) {
            $(".field").prop("readonly", true);
        } else {
            addDebris();
        }
        $(".debris_id").change(function () {
            var row = $(this).parent();
            if (row.is(':last-child')) {
                addDebris();
            }
        });
    });
</script>
<div class="col-lg-6">
    <form id="traitDebrisForm" method="post" action="traitdebrisWrite">
        <input type="hidden" name="moduleBase" value="traitdebris">
        <input type="hidden" name="trait_id" value="{$trait.trait_id}">
        <div class="row">
            <div class="table-responsive">
                <table id="traitDebrisList" class="table table-bordered table-hover ">
                    <thead>
                        <tr>
                            <th>{t}Id{/t}</th>
                            <th>{t}Débris{/t}</th>
                            <th>{t}Quantité{/t}</th>
                            {if $readOnly == 0}
                            <th class="center"><img src="display/images/remove-red-24.png" height="25"></th>
                            {/if}
                        </tr>
                    </thead>
                    <tbody>
                        {foreach $traitdebris as $td}
                        <tr id="debris{$td.trait_debit_id}">
                            <td class="center">
                                {$td.trait_debit_id}
                                <input type="hidden" name="td{$td.trait_debit_id}" value="{$td.trait_debit_id}">
                            </td>
                            <td>
                                <select class="field form-control debris_id" name="di{$td.trait_debit_id}">
                                    <option value="0">{t}Sélectionnez{/t}</option>
                                    {foreach $debris as $deb}
                                    <option value="{$deb.debris_id}" {if $deb.debris_id==$td.debris_id} selected{/if}>
                                        {$deb.debris_name} ({$deb.unite_comptage})
                                    </option>
                                    {/foreach}
                                </select>
                            </td>
                            <td>
                                <input class="field form-control" name="dq{$td.trait_debit_id}"
                                    value="{$td.debris_quantite}">
                            </td>
                            {if $readOnly == 0 && $rights.manage == 1}
                            <td class="center removeDebris" data-ligne="{$td.trait_debit_id}"><img
                                    src="display/images/remove-red-24.png" height="25"></td>
                            {/if}
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
        {if $readOnly == 0 && $rights.manage == 1}
        <div class="row">
            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
            </div>
        </div>
        {/if}
        {$csrf}
    </form>
</div>