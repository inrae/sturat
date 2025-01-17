<script>
$(document).ready(function() {
	$('.image-popup-no-margins').magnificPopup( {
		type: 'image',
		closeOnContentClick: true,
		closeBtnInside: false,
		fixedContentPos: true,
		mainClass: 'mfp-no-margins mfp-with-zoom', // class to remove default margin from left and right side
		image: {
			verticalFit: false
		},
		zoom: {
			enabled: true,
			duration: 300 // don't forget to change the duration also in CSS
		}
	});
} ) ;
</script>

<table id="documentList" class="table table-bordered table-hover" >
<thead>
<tr>
<th>N° poisson</th>
<th>Vignette</th>
<th>Nom du document</th>
<th>Description</th>
<th>Taille</th>
<th>Date<br>d'import</th>
{if $rights["gestion"] == 1 }
<th>Supprimer</th>
{/if}
</tr>
</thead>
<tbody>
{section name=lst loop=$dataDoc}
<tr>
<td class="center">
{if $rights.manage == 1}
<a href="individuChange?individu_id={$dataDoc[lst].individu_id}" title="Modifier les informations concernant le poisson">{$dataDoc[lst].individu_id}</a>
{else}
{$dataDoc[lst].individu_id}
{/if}
</td>
<td style="text-align:center;">
{if in_array($dataDoc[lst].mime_type_id, array(1,4,5,6,7))}
{if $dataDoc[lst].mime_type_id != 1}
<a class="image-popup-no-margins"
   href="documentGet&document_id={$dataDoc[lst].document_id}&attached=0&phototype=1"
   title="aperçu de la photo">
   <img src="documentGet&document_id={$dataDoc[lst].document_id}&attached=0&phototype=2" height="30">
{/if}

{if $dataDoc[lst].mime_type_id != 1}</a>{/if}
{/if}
<td>
<a href="documentGet?document_id={$dataDoc[lst].document_id}&attached=1&phototype=0"" title="document original">
{$dataDoc[lst].document_nom}
</a>

</td>
<td>{$dataDoc[lst].document_description}</td>
<td>{$dataDoc[lst].size}</td>
<td>{$dataDoc[lst].document_date_import}</td>
{if $rights["gestion"] == 1}
<td>
<div class="center">
<a href="documentDelete?document_id={$dataDoc[lst].document_id}&individu_id={$dataDoc[lst].individu_id}" onclick="return confirm('Confirmez-vous la suppression ?');">
<img src="display/images/corbeille.png" height="20">
</a>
</div>
</td>
{/if}
</tr>
{/section}
</tbody>
</table>
