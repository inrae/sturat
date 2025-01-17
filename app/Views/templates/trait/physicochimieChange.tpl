<h2>{t}Modification des données physico-chimiques - trait n° {/t}&nbsp;{$trait.trait_id} -
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
<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal " id="paramForm" method="post" action="physicochimieWrite">
            <input type="hidden" name="moduleBase" value="physicochimie">
            <input type="hidden" name="trait_id" value="{$trait.trait_id}">
            <div class="form-group">
                <label for="temperature" class="col-md-4 control-label">{t}Température (°C) :{/t}</label>
                <div class="col-md-8">
                    <input class="form-control taux" id="temperature" name="temperature" value="{$data.temperature}">
                </div>
            </div>
            <div class="form-group">
                <label for="conductivity" class="col-md-4 control-label">{t}Conductivité (mS/cm) :{/t}</label>
                <div class="col-md-8">
                    <input class="form-control taux" id="conductivity" name="conductivity" value="{$data.conductivity}">
                </div>
            </div>
            <div class="form-group">
                <label for="conductivity_specific" class="col-md-4 control-label">
                    {t}Conductivité spécifique à 25 °C, en mS/cm :{/t}</label>
                <div class="col-md-8">
                    <input class="form-control taux" id="conductivity_specific" name="conductivity_specific"
                        value="{$data.conductivity_specific}">
                </div>
            </div>
            <div class="form-group">
                <label for="salinity" class="col-md-4 control-label">{t}Salinité :{/t}</label>
                <div class="col-md-8">
                    <input class="form-control taux" id="salinity" name="salinity" value="{$data.salinity}">
                </div>
            </div>
            <div class="form-group">
                <label for="depth" class="col-md-4 control-label">{t}Profondeur (m) :{/t}</label>
                <div class="col-md-8">
                    <input class="form-control taux" id="depth" name="depth" value="{$data.depth}">
                </div>
            </div>
            <div class="form-group">
                <label for="depth_probe" class="col-md-4 control-label">
                    {t}Profondeur de mesure de la sonde :{/t}</label>
                <div class="col-md-8">
                    <input class="form-control taux" id="depth_probe" name="depth_probe" value="{$data.depth_probe}">
                </div>
            </div>
            <div class="form-group">
                <label for="oxygen_ppt" class="col-md-4 control-label">{t}Oxygene, en % de saturation :{/t}</label>
                <div class="col-md-8">
                    <input class="form-control taux" id="oxygen_ppt" name="oxygen_ppt" value="{$data.oxygene_ppt}">
                </div>
            </div>
            <div class="form-group">
                <label for="oxygen_mgl" class="col-md-4 control-label">{t}Oxygene, en mg/l :{/t}</label>
                <div class="col-md-8">
                    <input class="form-control taux" id="oxygen_mgl" name="oxygen_mgl" value="{$data.oxygen_mgl}">
                </div>
            </div>
            <div class="form-group">
                <label for="turbidity" class="col-md-4 control-label">{t}Turbidité, en NTU :{/t}</label>
                <div class="col-md-8">
                    <input class="form-control taux" id="turbidity" name="turbidity" value="{$data.turbidity}">
                </div>
            </div>
            <div class="form-group">
                <label for="ph" class="col-md-4 control-label">{t}pH :{/t}</label>
                <div class="col-md-8">
                    <input class="form-control taux" id="ph" name="ph" value="{$data.ph}">
                </div>
            </div>
            <div class="form-group">
                <label for="comment" class="col-md-4 control-label">{t}Commentaires :{/t}</label>
                <div class="col-md-8">
                    <textarea class="form-control" id="comment" name="comment">{$data.comment}</textarea>
                </div>
            </div>
            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
            </div>
            {$csrf}
        </form>
    </div>
</div>