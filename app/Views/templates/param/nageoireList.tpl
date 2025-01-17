<h2>{t}Liste des types de nageoires{/t}</h2>
<div class="row">
	<div class="col-md-6">
		{if $rights.param == 1 && $readOnly == 0}
		<a href="nageoireChange?fin_id=0">
			<img src="display/images/new.png" height="25">
			{t}Nouveau...{/t}
		</a>
		{/if}
		<table id="paramList" class="table table-bordered table-hover datatable ">
			<thead>
				<tr>
					<th>{t}Id{/t}</th>
					<th>{t}Libellé{/t}</th>
				</tr>
			</thead>
			<tbody>
				{foreach $data as $row}
				<tr>
					<td class="center">{$row.fin_id}</td>
					<td>
						{if $rights.param == 1 && $readOnly==0}
						<a href="nageoireChange?nageoire_id={$row.fin_id}">
							{$row.fin_name}
						</a>
						{else}
						{$row.fin_name}
						{/if}
					</td>
				</tr>
				{/foreach}
			</tbody>
		</table>
	</div>
</div>
