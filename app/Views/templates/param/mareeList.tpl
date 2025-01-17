<h2>{t}Liste des marées{/t}</h2>
<div class="row">
	<div class="col-md-6">
		{if $rights.param == 1 && $readOnly == 0}
		<a href="mareeChange?maree_id=0">
			<img src="display/images/new.png" height="25">
			{t}Nouveau...{/t}
		</a>
		{/if}
		<table id="paramList" class="table table-bordered table-hover datatable ">
			<thead>
				<tr>
					<th>{t}Id{/t}</th>
					<th>{t}Nom{/t}</th>
				</tr>
			</thead>
			<tbody>
				{foreach $data as $row}
				<tr>
					<td class="center">{$row.maree_id}</td>
					<td>
						{if $rights.param == 1 && $readOnly==0}
						<a href="mareeChange?maree_id={$row.maree_id}">
							{$row.maree_libelle}
						</a>
						{else}
						{$row.maree_libelle}
						{/if}
					</td>
				</tr>
				{/foreach}
			</tbody>
		</table>
	</div>
</div>
