<h2>Liste des espèces</h2>
{include file="param/especeSearch.tpl"}
{if $isSearch == 1}
{if $rights["param"] == 1 && $readOnly == 0}
<a href="especeChange?espece_id=0">
<img src="display/images/new.png" height="25">Nouvelle espèce...</a>
{/if}
<table id="especeList" class="table table-bordered table-hover datatable display">
<thead>
<tr>
{if $rights.param == 1 && $readOnly == 0}
<th class="center"><img src="display/images/edit.gif" height="25"></th>
{/if}
<th>{t}Nom latin{/t}</th>
<th>{t}Nom français{/t}</th>
<th>{t}Phylum{/t}</th>
<th>{t}Subphylum{/t}</th>
<th>{t}Classe{/t}</th>
<th>{t}Ordre{/t}</th>
<th>{t}Famille{/t}</th>
<th>{t}Code Perm Ifremer{/t}</th>
<th>{t}Code Sandre{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
{if $rights.param == 1 && $readOnly == 0}
<td>
<a href="especeChange?espece_id={$data[lst].espece_id}">
<img src="display/images/edit.gif" height="25">
</a>
</td>
{/if}
<td>{$data[lst].nom} {$data[lst].auteur}</td>
<td>{$data[lst].nom_fr}</td>
<td>{$data[lst].phylum}</td>
<td>{$data[lst].subphylum}</td>
<td>{$data[lst].classe}</td>
<td>{$data[lst].ordre}</td>
<td>{$data[lst].famille}</td>
<td class="center">{$data[lst].code_perm_ifremer}</td>
<td class="center">{$data[lst].code_sandre}</td>
</tr>
{/section}
</tbody>
</table>
<br>
{/if}
