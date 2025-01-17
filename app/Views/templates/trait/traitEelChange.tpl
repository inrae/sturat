<script>
    $(document).ready(function () {
        var readOnly = "{$readOnly}";
        var gestion = "{$rights.manage}";
        if (readOnly == 1 || gestion != 1) {
            $(".field").prop("readonly", true);
        }
        /*
        valeurs utilisees pour calculer la probabilite d'argenture de l'anguille
        formule : const + a x ILN + b x OI
        premiere lettre : j : calcul pour jaune, a : calcul pour argente
        derniers chiffres : 0 : Long totale <= 450 mm, 450 : long totale > 450 mm
        calcul ILN : L pectorale/L totale x 100
        calcul OI : ((25 x pi) / (l totale x 8)) x ((diam occ horizontal x 2 )2 + (diam occ vertical x 2)2 )
        */
        var jconst450 = -32.839
        var ja450 = 11.478
        var jb450 = 3.217
        var jconst0 = -33.211
        var ja0 = 13.875
        var jb0 = 3.045
        var aconst450 = -62.402
        var aa450 = 14.511
        var ab450 = 5.253
        var aconst0 = -68.814
        var aa0 = 16.832
        var ab0 = 6.479
        function calculStade() {
            var lt = $("#total_length").val();
            var pl = $("#pectoral_length").val();
            var occv = $("#vert_diam_eyepiece").val();
            var occh = $("#hori_diam_eyepiece").val();
            var oi = "", iln = "", j = "", a = "", stade = "";
            if (lt > 0 && pl > 0 && occv > 0 && occh > 0) {
                var iln = pl / lt * 100;
                var oi = ((25 * Math.PI) / (lt * 8)) * (Math.pow((occv * 2), 2) + Math.pow((occh * 2), 2));
                if (lt > 450) {
                    j = jconst450 + (ja450 * iln) + (jb450 * oi);
                    a = aconst450 + (aa450 * iln) + (ab450 * oi);
                } else {
                    j = jconst0 + (ja0 * iln) + (jb0 * oi);
                    a = aconst0 + (aa0 * iln) + (ab0 * oi);
                }
                if (j > a) {
                    stade = 1;
                } else {
                    stade = 2;
                }
            }
            $("#val_oi").val(oi);
            $("#val_iln").val(iln);
            $("#val_j").val(j);
            $("#val_a").val(a);
            $("#eel_stade_id").val(stade).change();
        }
        $(".calcul").change(function () {
            calculStade();
        });
    });
</script>

<h2>{t}Création/modification d'une anguille - trait n° {/t}&nbsp;{$trait.trait_id} -
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
<form class="form-horizontal" id="eelForm" method="post" action="individuEelWrite">
    <input type="hidden" name="moduleBase" value="individuEel">
    <input type="hidden" name="trait_id" value="{$trait.trait_id}">
    <input type="hidden" name="individu_eel_id" value="{$data.individu_eel_id}">
    <div class="row">
        <div class="form-group">
            <label for="total_length" class="col-md-4 control-label">{t}Longueur totale (mm) :{/t}</label>
            <div class="col-md-8">
                <input class="form-control taux field calcul" id="total_length" name="total_length"
                    value="{$data.total_length}">
            </div>
        </div>
    </div>
    <div class="form-group">
        <label for="pectoral_length" class="col-md-4 control-label">{t}Longueur de la pectorale (mm) :{/t}</label>
        <div class="col-md-8">
            <input class="form-control taux field calcul" id="pectoral_length" name="pectoral_length"
                value="{$data.pectoral_length}">
        </div>
    </div>
    <div class="form-group">
        <label for="hori_diam_eyepiece" class="col-md-4 control-label">
            {t}Diamètre horizontal de l'œil (mm) :{/t}</label>
        <div class="col-md-8">
            <input class="form-control taux field calcul" id="hori_diam_eyepiece" name="hori_diam_eyepiece"
                value="{$data.hori_diam_eyepiece}">
        </div>
    </div>
    <div class="form-group">
        <label for="vert_diam_eyepiece" class="col-md-4 control-label">{t}Diamètre vertical de l'œil (mm) :{/t}</label>
        <div class="col-md-8">
            <input class="form-control taux field calcul" id="vert_diam_eyepiece" name="vert_diam_eyepiece"
                value="{$data.vert_diam_eyepiece}">
        </div>
    </div>
    <div class="form-group">
        <label for="observation" class="col-md-4 control-label">{t}Observations :{/t}</label>
        <div class="col-md-8">
            <textarea class="form-control field" id="observation" name="observation">{$data.observation}</textarea>
        </div>
    </div>
    <div class="form-group">
        <label for="eel_stade_id" class="col-md-4 control-label">{t}Stade :{/t}</label>
        <div class="col-md-8">
            <select class="form-control field" id="eel_stade_id" name="eel_stade_id" {if $readOnly==1}readonly{/if}>
                <option value="" {if $data.eel_stade_id=="" } selected{/if}>{t}Inconnu{/t}</option>
                <option value="1" {if $data.eel_stade_id==1} selected{/if}>{t}jaune{/t}</option>
                <option value="2" {if $data.eel_stade_id==2} selected{/if}>{t}argentée{/t}</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="val_oi" class="col-md-4 control-label">{t}Valeur oi calculée :{/t}</label>
        <div class="col-md-8">
            <input class="form-control taux" id="val_oi" name="val_oi" value="{$data.val_oi}" readonly>
        </div>
    </div>
    <div class="form-group">
        <label for="val_iln" class="col-md-4 control-label">{t}Valeur iln calculée :{/t}</label>
        <div class="col-md-8">
            <input class="form-control taux" id="val_iln" name="val_iln" value="{$data.val_iln}" readonly>
        </div>
    </div>
    <div class="form-group">
        <label for="val_j" class="col-md-4 control-label">{t}Valeur j calculée :{/t}</label>
        <div class="col-md-8">
            <input class="form-control taux" id="val_j" name="val_j" value="{$data.val_j}" readonly>
        </div>
    </div>
    <div class="form-group">
        <label for="val_a" class="col-md-4 control-label">{t}Valeur a calculée :{/t}</label>
        <div class="col-md-8">
            <input class="form-control taux" id="val_a" name="val_a" value="{$data.val_a}" readonly>
        </div>
    </div>
    <div class="form-group">
        <label for="fork_length" class="col-md-4 control-label">{t}Longueur à la fourche (mm) :{/t}</label>
        <div class="col-md-8">
            <input class="form-control taux field" id="fork_length" name="fork_length" value="{$data.fork_length}">
        </div>
    </div>
    <div class="form-group">
        <label for="weight" class="col-md-4 control-label">{t}Masse (g) :{/t}</label>
        <div class="col-md-8">
            <input class="form-control taux field" id="weight" name="weight" value="{$data.weight}">
        </div>
    </div>
    {if $readOnly == 0 && $rights.manage == 1}
    <div class="row">
        <div class="form-group center">
            <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
            {if $data.individu_eel_id > 0 }
            <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
            {/if}
        </div>
    </div>
    {/if}
    {$csrf}
</form>