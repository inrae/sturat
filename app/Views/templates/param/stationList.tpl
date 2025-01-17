<h2>{t}Liste des stations{/t}</h2>
<div class="row">
	<div class="col-md-6">
		{if $rights.param == 1 && $readOnly == 0}
		<a href="stationChange?fin_id=0">
			<img src="display/images/new.png" height="25">
			{t}Nouveau...{/t}
		</a>
		{/if}
		<table id="paramList" class="table table-bordered table-hover datatable ">
			<thead>
				<tr>
					<th>{t}Id{/t}</th>
					<th>{t}Code{/t}</th>
				</tr>
			</thead>
			<tbody>
				{foreach $data as $row}
				<tr>
					<td class="center">{$row.station_id}</td>
					<td>
						{if $rights.param == 1 && $readOnly==0}
						<a href="stationChange?station_id={$row.station_id}">
							{$row.station_code}
						</a>
						{else}
						{$row.station_code}
						{/if}
					</td>
				</tr>
				{/foreach}
			</tbody>
		</table>
	</div>
</div>
