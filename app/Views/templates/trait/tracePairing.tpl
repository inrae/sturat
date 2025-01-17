<script>
    $(document).ready(function () {
        $(".source").draggable({
            revert: "invalid",
            cursor: "move",
            helper: "clone"
        });
        $(".dest").droppable({
            hoverClass: "ui-state-active",
            drop: function (event, ui) {
                var content = $("input", ui.draggable).val();
                $("input", ui.draggable).val("");
                if (content === undefined) {
                    content = ui.draggable.text();
                    $(ui.draggable).addClass("blue");
                }
                $("input", this).val(content);
            }
        });
    });
</script>
<h2>{t}Apparier les traces GPX avec les traits{/t}</h2>

<div class="row">
    <form class="form-horizontal " id="traitSearch" action="tracePairing" method="GET">
        <input type="hidden" name="isSearch" value="1">
        <fieldset class="col-md-6">
            <legend>{t}Traits à apparier{/t}</legend>
            <div class="form-group">
                <label for="trait_id" class="col-md-2 control-label">{t}N° du trait :{/t}</label>
                <div class="col-md-2">
                    <input class="form-control" id="trait_id" name="trait_id" value="{$dataSearch.trait_id}">
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
        </fieldset>
        <fieldset class="col-md-6">
            <legend>{t}Traces importées{/t}</legend>
            <div class="form-group">
                <label for="trace_import_from" class="col-md-3 control-label right">{t}Date d'import - du :{/t}</label>
                <div class="col-md-3">
                    <input class="datepicker form-control" name="trace_import_from"
                        value="{$dataSearch.trace_import_from}">
                </div>
                <label for="trace_import_to" class="col-md-3 control-label right">{t}au :{/t}</label>
                <div class="col-md-3">
                    <input class="datepicker form-control" name="trace_import_to" value="{$dataSearch.trace_import_to}">
                </div>
            </div>
        </fieldset>
        <div class="row">
            <div class="col-md-4 center">
                <input type="submit" class="btn btn-success" value="{t}Rechercher{/t}">
            </div>
        </div>
        {$csrf}
    </form>
</div>
<!-- Display the tables-->
<form id="pairingExec" method="post" action="tracePairingExec">
    <div class="row">
        <fieldset class="col-md-6">
            <legend>{t}Traits{/t}</legend>
            <table id="traitList" class="table table-bordered table-hover datatable-nopaging-nosearching "
                data-order='[[1, "asc"]]'>
                <thead>
                    <tr>
                        <th>{t}Id{/t}</th>
                        <th>{t}Date début{/t}</th>
                        <th>{t}Station{/t}</th>
                        <th>{t}N° de la trace à apparier{/t}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $traits as $trait}
                    <tr>
                        <td class="center">{$trait.trait_id}</td>
                        <td>{$trait.trait_start}</td>
                        <td>{$trait.station_code}</td>
                        <td class="dest">
                            <input class="nombre" name="trait{$trait.trait_id}">
                        </td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </fieldset>
        <fieldset class="col-md-6">
            <legend>{t}Traces à apparier{/t}</legend>
            <table id="tracesId" class="table table-bordered table-hover datatable-nopaging-nosearching ">
                <thead>
                    <tr>
                        <th>{t}Id{/t}</th>
                        <th>{t}Nom du fichier{/t}</th>
                        <th>{t}Nom saisi{/t}</th>
                        <th>{t}Date d'import{/t}</th>
                        <th>{t}Nbre de points{/t}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $traces as $trace}
                    <tr>
                        <td class="source">{$trace.ogc_fid}</td>
                        <td>{$trace.filename}</td>
                        <td>{$trace.name}</td>
                        <td>{$trace.importdate}</td>
                        <td class="center">{$trace.nb_points}</td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </fieldset>
    </div>

    <div class="row">
        <div class="center">
            <input type="submit" class="btn btn-success" value="{t}Apparier les traces{/t}">
        </div>
    </div>

    {$csrf}
</form>
<div class="row">
    <div class="center">
        {t}Tapez le numéro de la trace à apparier, ou déplacez-là à la souris{/t}
    </div>
</div>