<h2>{t}Liste des types d'engins{/t}</h2>
<div class="row">
	<div class="col-md-6">
		{if $rights.param == 1 && $readOnly == 0}
		<a href="enginTypeChange?engin_type_id=0">
			<img src="display/images/new.png" height="25">
			{t}Nouveau...{/t}
		</a>
		{/if}
		<table id="paramList" class="table table-bordered table-hover datatable ">
			<thead>
				<tr>
					<th>{t}Id{/t}</th>
					<th>{t}Nom{/t}</th>
          <th>{t}Description{/t}</th>
				</tr>
			</thead>
			<tbody>
				{foreach $data as $row}
				<tr>
					<td class="center">{$row.engin_type_id}</td>
					<td>
						{if $rights.param == 1 && $readOnly==0}
						<a href="enginTypeChange?engin_type_id={$row.engin_type_id}">
							{$row.engin_type_libelle}
						</a>
						{else}
						{$row.engin_type_libelle}
						{/if}
					</td>
          <td>{$row.engin_type_description}</td>
				</tr>
				{/foreach}
			</tbody>
		</table>
	</div>
</div>
