<script>
	$(document).ready(function () {
			$(".selectEdit").change(function () {
				$(this).next(".form-control").val($(this).val());
			});
			/*
			 * Fonction de recherche des select lies au parent
			 */
			function fieldSearch(id, parentId, valeur) {
				var subid;
				var url = "index.php";
				switch (id) {
					case "phylum":
						subid = "subphylum";
						break;
					case "subphylum":
						subid = "classe";
						break;
					case "classe":
						subid = "ordre";
						break;
					case "ordre":
						subid = "famille";
						break;
					case "famille":
						subid = "genre";
				}
				var options = "";
				$.getJSON(url, {
					"module": "especeGetValues",
					"value": valeur,
					"field": subid,
					"parentField": parentId
				}, function (data) {
					options = '<option value="" selected></option>';
					for (var i = 0; i < data.length; i++) {
						options += '<option value="' + data[i].field + '">'
							+ data[i].field + '</option>';
					}
					;
					$("#" + subid).html(options);
				});
				if (subid) {
					fieldSearch(subid, parentId, valeur);
				}
			}
			;

			$(".selection").change(function () {
				var currentId = $(this).attr('id');
				var valeur = $(this).val();
				fieldSearch(currentId, currentId, valeur);
			});

		});
</script>
<h2>{t}Modification d'une espèce{/t}</h2>

<a href="especeList"><img src="display/images/list.png" height="25">{t}Retour à la liste{/t}</a>
<div class="formSaisie">
	<form class="form-horizontal " method="post" action="especeWrite">

		<div>
			<input type="hidden" name="moduleBase" value="espece">
			<input type="hidden" name="espece_id" value="{$data.espece_id}">
			<input type="hidden" name="idParent" value="{$data.idParent}">

			<div class="form-group">
				<label for="nom" class="control-label col-md-4">
					Nom latin <span class="red">*</span> :
				</label>
				<div class="col-md-8">
					<input class="form-control" id="nom" name="nom" required value="{$data.nom}">
				</div>
			</div>
			<div class="form-group">
				<label for="nom_fr" class="control-label col-md-4">Nom français :</label>
				<div class="col-md-8">
					<input id="nom_fr" name="nom_fr" value="{$data.nom_fr}" class="form-control">
				</div>
			</div>

			<div class="form-group">
				<label for="auteur" class="control-label col-md-4">Auteur :</label>
				<div class="col-md-8">
					<select id="auteur" class="form-control selectEdit ">
						<option value="" {if $data.auteur=="" }selected{/if}>
						{section name=lst loop=$auteur}
							<option value="{$auteur[lst].field}" {if $data.auteur==$auteur[lst].field}selected{/if}>
								{$auteur[lst].field}
							</option>
						{/section}
					</select>
					<input class="form-control" name="auteur" value="{$data.auteur}">
				</div>
			</div>

			<div class="form-group">
				<label for="phylum" class="control-label col-md-4">Phylum :</label>
				<div class="col-md-8">
					<select id="phylum" class="form-control selectEdit selection">
						<option value="" {if $data.phylum=="" }selected{/if}>
						{section name=lst loop=$phylum}
							<option value="{$phylum[lst].field}" {if $data.phylum==$phylum[lst].field}selected{/if}>
								{$phylum[lst].field}
							</option>
							{/section}
					</select>
					<input class="form-control" name="phylum" value="{$data.phylum}">
				</div>
			</div>

			<div class="form-group">
				<label for="" class="control-label col-md-4">Subphylum :</label>
				<div class="col-md-8">
					<select id="subphylum" class="form-control selectEdit  selection">
						<option value="" {if $data.subphylum=="" }selected{/if}>
						{section name=lst loop=$subphylum}
							<option value="{$subphylum[lst].field}" {if $data.subphylum==$subphylum[lst].field}selected{/if}>
								{$subphylum[lst].field}
							</option>
						{/section}
					</select>
					<input class="form-control" name="subphylum" value="{$data.subphylum}">
				</div>
			</div>

			<div class="form-group">
				<label for="" class="control-label col-md-4">Classe :</label>
				<div class="col-md-8">
					<select id="classe" class="form-control selectEdit  selection">
						<option value="" {if $data.classe=="" }selected{/if}>
						{section name=lst loop=$classe}
							<option value="{$classe[lst].field}" {if $data.classe==$classe[lst].field}selected{/if}>
								{$classe[lst].field}
							</option>
						{/section}
					</select>
					<input class="form-control" name="classe" value="{$data.classe}">
				</div>
			</div>

			<div class="form-group">
				<label for="" class="control-label col-md-4">Ordre :</label>
				<div class="col-md-8">
					<select id="ordre" class="form-control selectEdit  selection">
						<option value="" {if $data.ordre=="" }selected{/if}>
						{section name=lst loop=$ordre}
							<option value="{$ordre[lst].field}" {if $data.ordre==$ordre[lst].field}selected{/if}>
								{$ordre[lst].field}
							</option>
						{/section}
					</select>
					<input class="form-control" name="ordre" value="{$data.ordre}">
				</div>
			</div>


			<div class="form-group">
				<label for="" class="control-label col-md-4">Famille :</label>
				<div class="col-md-8">
					<select id="famille" class="form-control selectEdit  selection">
						<option value="" {if $data.famille=="" }selected{/if}>
						{section name=lst loop=$famille}
							<option value="{$famille[lst].field}" {if $data.famille==$famille[lst].field}selected{/if}>
								{$famille[lst].field}
							</option>
						{/section}
					</select>
					<input class="form-control" name="famille" value="{$data.famille}">
				</div>
			</div>

			<div class="form-group">
				<label for="genre" class="control-label col-md-4">Genre :</label>
				<div class="col-md-8">
					<select id="genre" class="form-control selectEdit  selection">
						<option value="" {if $data.genre=="" }selected{/if}>
						{section name=lst loop=$genre}
							<option value="{$genre[lst].field}" {if $data.genre==$genre[lst].field}selected{/if}>
								{$genre[lst].field}
							</option>
						{/section}
					</select>
					<input class="form-control" name="genre" value="{$data.genre}">
				</div>
			</div>

			<div class="form-group">
				<label for="code_sandre" class="control-label col-md-4">Code Sandre :</label>
				<div class="col-md-8">
					<input id="code_sandre" name="code_sandre" value="{$data.code_sandre}" class="form-control num5 ">
				</div>
			</div>
			<div class="form-group">
				<label for="code_perm_ifremer" class="control-label col-md-4">Code Perm Ifremer :</label>
				<div class="col-md-8">
					<input id="code_perm_ifremer" name="code_perm_ifremer" value="{$data.code_perm_ifremer}"
						class="form-control num5 ">
				</div>
			</div>
			{if $rights["param"] == 1 && $readOnly == 0}
				<div class="form-group center">
					<button type="submit" class="btn btn-primary button-valid">Valider</button>
					{if $data.espece_id > 0 && $data.children == 0}
					<button class="btn btn-danger button-delete">Supprimer</button>
					{/if}
				</div>
			{/if}

		</div>
	{$csrf}</form>
</div>

<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>
