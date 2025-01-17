<h2>{t}Liste des traits{/t}</h2>
<!-- recherche des traits à implémenter-->
<div class="row">
	<div class="col-lg-6">
		<form class="form-horizontal " id="traitSearch" action="traitList" method="GET">
			<input type="hidden" name="isSearch" value="1">
			<div class="form-group">
				<label for="trait_id" class="col-md-2 control-label">{t}N° du trait :{/t}</label>
				<div class="col-md-2">
					<input class="form-control" id="trait_id" name="trait_id" value="{$dataSearch.trait_id}" autofocus>
				</div>
				<label for="station_id" class="col-md-2 control-label">{t}Station :{/t}</label>
				<div class="col-md-2">
					<select id="station_id" name="station_id" class="form-control">
						<option value="" {if $dataSearch.station_id=="" }selected{/if}>{t}Choisissez...{/t}</option>
						{foreach $stations as $station}
						<option value="{$station.station_id}" {if
							$station.station_id==$dataSearch.station_id}selected{/if}>
							{$station.station_code}
						</option>
						{/foreach}
					</select>
				</div>
				<div class="col-md-4 center">
					<input type="submit" class="btn btn-success" value="{t}Rechercher{/t}">
				</div>
			</div>
			<div class="form-group">
				<label for="from" class="col-md-2 control-label">{t}Du :{/t}</label>
				<div class="col-md-2">
					<input class="datepicker form-control" name="from" value="{$dataSearch.from}">
				</div>
				<label for="to" class="col-md-2 control-label">{t}au :{/t}</label>
				<div class="col-md-2">
					<input class="datepicker form-control" name="to" value="{$dataSearch.to}">
				</div>
			</div>
			{$csrf}
		</form>
	</div>
</div>
<div class="row">

	<div class="col-lg-8">
		{if $rights.manage == 1 && $readOnly == 0}
		<a href="traitChange?trait_id=0">
			<img src="display/images/new.png" height="25">
			{t}Nouveau trait{/t}
		</a>
		{/if}

		<table id="traitList" class="table table-bordered table-hover datatable " data-order='[[1, "desc"]]'>
			<thead>
				<tr>
					<th>{t}Id{/t}</th>
					<th>{t}Date début{/t}</th>
					<th>{t}Date de fin{/t}</th>
					<th>{t}Durée{/t}</th>
					<th>{t}Station{/t}</th>
					<th>{t}Commentaires{/t}</th>
				</tr>
			</thead>
			<tbody>
				{foreach $data as $row}
				<tr>
					<td class="center">
						<a href="traitDisplay?trait_id={$row.trait_id}" title="{t}Afficher-modifier{/t}">
							{$row.trait_id}
						</a>
					</td>
					<td class="center nowrap">{$row.trait_start}</td>
					<td class="center nowrap">{$row.trait_end}</td>
					<td class="center">{$row.duration}</td>
					<td class="center">{$row.station_code}</td>
					<td>{$row.remarks}</td>
				</tr>
				{/foreach}
			</tbody>
		</table>
	</div>
</div>