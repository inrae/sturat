<h2>{t}Création - Modification d'un manipulateur{/t}</h2>
<a href="manipulateurList"><img src="display/images/list.png" height="25">{t}Retour à la liste{/t}</a>
<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal " id="paramForm" method="post" action="manipulateurWrite">
            <input type="hidden" name="moduleBase" value="manipulateur">
            <input type="hidden" name="manipulateur_id" value="{$data.manipulateur_id}">
            <div class="form-group">
                <label for="name" class="control-label col-md-4"><span class="red">*</span> 
                    {t}Nom :{/t}</label>
                <div class="col-md-8">
                    <input id="name" type="text" class="form-control" name="name" value="{$data.name}" autofocus
                        required>
                </div>
            </div>
            <div class="form-group">
                <label for="firstname" class="control-label col-md-4">
                    {t}Prénom :{/t}</label>
                <div class="col-md-8">
                    <input id="firstname" type="text" class="form-control" name="firstname" value="{$data.firstname}">
                </div>
            </div>
            <div class="form-group">
                <label for="actif1" class="col-md-4 control-label"><span class="red">*</span>
                    {t}Manipulateur en activité ?{/t}</label>
                <div class="col-md-8">
                    <input class="" type="radio" id="actif1" name="actif" value="1" {if
                        $data.actif==1}checked{/if}>&nbsp;{t}oui{/t}
                    <input class="" type="radio" id="actif0" name="actif" value="2" {if
                        $data.actif==2}checked{/if}>&nbsp;{t}non{/t}
                </div>
            </div>
            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.manipulateur_id > 0 }
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
            {$csrf}
        </form>
    </div>
</div>
<span class="red">*</span><span class="messagebas">{t}Donnée obligatoire{/t}</span>