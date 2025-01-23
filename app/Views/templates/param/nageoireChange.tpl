<h2>{t}Création - Modification d'un type de nageoire{/t}</h2>
<a href="nageoireList"><img src="display/images/list.png" height="25">{t}Retour à la liste{/t}</a>
<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal " id="paramForm" method="post" action="nageoireWrite">
            <input type="hidden" name="moduleBase" value="nageoire">
            <input type="hidden" name="fin_id" value="{$data.fin_id}">
            <div class="form-group">
                <label for="paramName" class="control-label col-md-4"><span class="red">*</span> 
                    {t}Libellé :{/t}</label>
                <div class="col-md-8">
                    <input id="paramName" type="text" class="form-control" name="fin_name" value="{$data.fin_name}"
                        autofocus required>
                </div>
            </div>
            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.fin_id > 0 }
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
            {$csrf}
        </form>
    </div>
</div>
<span class="red">*</span><span class="messagebas">{t}Donnée obligatoire{/t}</span>