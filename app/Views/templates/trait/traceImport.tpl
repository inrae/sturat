<h2>{t}Import des traces GPX{/t}</h2>
<div class="row">
    <div class="col-md-6 form-display">
        {t}Cette fonction vous permet d'importer dans une table temporaire toutes les traces présentes dans un fichier
        GPX. Vous pourrez ensuite associer ces traces avec les traits correspondants.{/t}
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <form id="importTrace" class="form-horizontal" method="post" action="importTraceExec"
            enctype="multipart/form-data">
            <div class="form-group">
                <label for="filename" class="control-label col-md-4">
                    {t}Fichier à importer :{/t} <br>(GPX)
                </label>
                <div class="col-md-7">
                    <input id="filename" type="file" class="form-control" name="upload" required>
                </div>
            </div>
            <div class="form-group center">
                <button type="submit" class="btn btn-primary">{t}Charger le fichier{/t}</button>
            </div>
            {$csrf}
        </form>
    </div>
</div>