<h2>{t}Importation des fichiers CINNA{/t}</h2>
<div class="row">
    <div class="col-md-6 form-display">
        {t}Cette fonction vous permet d'importer les fichiers CINNA dans la base de données estuaire_phy, schéma
        CINNA{/t}
        <br>
        {t}Attention : l'opération n'est à réaliser qu'une seule fois pour chaque fichier : dans le cas contraire, les
        enregistrements seront en double.{/t}
        <br>
        <b>{t}Après l'importation, veuillez noter les numéros des identifiants générés, avec le nom du fichier
            correspondant, pour pouvoir revenir en arrière si c'était nécessaire.{/t}</b>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <form id="importCinna" class="form-horizontal" method="post" action="importCinnaExec"
            enctype="multipart/form-data">
            <div class="form-group">
                <label for="cinnaFiles" class="control-label col-md-4">
                    {t}Fichier à importer :{/t} <br>(.GZ)
                </label>
                <div class="col-md-7">
                    <input id="cinnaFiles" type="file" class="form-control" name="cinnaFiles[]" required
                        accept="application/gzip,*.gz" multiple>
                </div>
            </div>
            <div class="form-group center">
                <button type="submit" class="btn btn-primary">{t}Importer le(s) fichier(s){/t}</button>
            </div>
            {$csrf}
        </form>
    </div>
</div>