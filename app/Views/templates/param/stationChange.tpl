<h2>{t}Création - Modification d'un type de station{/t}</h2>
<a href="stationList"><img src="display/images/list.png" height="25">{t}Retour à la liste{/t}</a>
<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal " id="paramForm" method="post" action="stationWrite">
            <input type="hidden" name="moduleBase" value="station">
            <input type="hidden" name="station_id" value="{$data.station_id}">
            <div class="form-group">
                <label for="paramName" class="control-label col-md-4"><span class="red">*</span> {t}Libellé
                    :{/t}</label>
                <div class="col-md-8">
                    <input id="paramName" type="text" class="form-control" name="station_code"
                        value="{$data.station_code}" autofocus required>
                </div>
            </div>
            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.station_id > 0 }
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
            {$csrf}
        </form>
    </div>
</div>
<span class="red">*</span><span class="messagebas">{t}Donnée obligatoire{/t}</span>