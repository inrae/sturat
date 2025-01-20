<script>
    $(document).ready(function () {
        function convertGPStoDD(valeur) {
            var parts = valeur.trim().split(/[^\d]+/);
            var dd = parseFloat(parts[0])
                + parseFloat((parts[1] + "." + parts[2]) / 60);
            var lastChar = valeur.substr(-1).toUpperCase();
            dd = truncator(dd, 6);
            if (lastChar == "S" || lastChar == "W" || lastChar == "O") {
                dd *= -1;
            }
            ;
            return dd;
        }

        /*
        * Initialisation of sexagesimal coordinates
        */
        $("#pos_deb_lat").val(toDegreesMinutes("{$data.latitude_start}", "lat"));
        $("#pos_deb_lon").val(toDegreesMinutes("{$data.longitude_start}", "lon"));
        $("#pos_fin_lat").val(toDegreesMinutes("{$data.latitude_end}", "lat"));
        $("#pos_fin_lon").val(toDegreesMinutes("{$data.longitude_end}", "lon"));
        /*
        * Conversion of sexagesimal coordinates
        */
        $(".gps_source").change(function () {
            var sourcename = $(this).attr("name");
            var destname = sourcename + "_dd";
            $('#' + destname).val(convertGPStoDD($(this).val()));
            if (sourcename.substring(0, 7) == "pos_deb") {
                $(".startpoint").change();
            } else {
                $(".endpoint").change();
            }
            $("#" + destname).change();
        });
        $(".startpoint").change(function () {
            if ($("#pos_deb_lat_dd").val().length > 0 && $("#pos_deb_lon_dd").val().length > 0) {
                setPosition(0, $("#pos_deb_lat_dd").val(), $("#pos_deb_lon_dd").val(), "{t}Début{/t}");
            }
        });
        $(".endpoint").change(function () {
            if ($("#pos_fin_lat_dd").val().length > 0 && $("#pos_fin_lon_dd").val().length > 0) {
                setPosition(1, $("#pos_fin_lat_dd").val(), $("#pos_fin_lon_dd").val(), "{t}Fin{/t}");
            }
        });
        $(".gps").change(function () {
            var destname = $(this).attr("id").substring(0, 11);
            var lonlat = destname.substring(8);
            var dms = toDegreesMinutesAndSeconds($(this).val(), lonlat);
            $("#" + destname).val(dms);
        });
        /**
         * Map initialisation
         */
        if ($("#pos_deb_lat_dd").val().length > 0 && $("#pos_deb_lon_dd").val().length > 0) {
            setPosition(0, $("#pos_deb_lat_dd").val(), $("#pos_deb_lon_dd").val(), "{t}Début{/t}");
        }
        if ($("#pos_fin_lat_dd").val().length > 0 && $("#pos_fin_lon_dd").val().length > 0) {
            setPosition(1, $("#pos_fin_lat_dd").val(), $("#pos_fin_lon_dd").val(), "{t}Fin{/t}");
        }
        $("#station_id").change(function () {
            var id = $(this).val();
            $.ajax({
                url: "stationGetPoints",
                data: {  "station_id": id }
            })
                .done(function (value) {
                    try {
                        var stationPoints = JSON.parse(value);
                    } catch (error) {
                        var stationPoints = [];
                    }
                    setStationPoints(stationPoints);
                });
        });
    });
</script>
<h2>{t}Création/Modification du trait{/t}{if $data.trait_id > 0}&nbsp;{$data.trait_id}</b>{/if}</h2>
<div class="row">
    <a href="traitList">
        <img src="display/images/list.png" height="25">
        {t}Retour à la liste{/t}
    </a>
    {if $data.trait_id > 0}
    &nbsp;
    <a href="traitDisplay?trait_id={$data.trait_id}">
        <img src="display/images/display.png" height="25">
        {t}Retour au détail{/t}
    </a>
    {/if}
</div>
<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal " id="paramForm" method="post" action="traitWrite">
            <input type="hidden" name="moduleBase" value="trait">
            <input type="hidden" name="trait_id" value="{$data.trait_id}">
            <fieldset>
                <legend>{t}Informations générales{/t}</legend>
                <div class="form-group">
                    <label for="station_id" class="col-md-4 control-label"><span class="red">*</span>
                        {t}Station :{/t}</label>
                    <div class="col-md-8">
                        <select class="form-control" id="station_id" name="station_id" autofocus>
                            {foreach $stations as $station}
                            <option value="{$station.station_id}" {if
                                $station.station_id==$data.station_id}selected{/if}>{$station.station_code}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="trait_start" class="col-md-4 control-label"><span class="red">*</span>
                        {t}Début :{/t}</label>
                    <div class="col-md-8">
                        <input class="form-control datetimepicker" id="trait_start" name="trait_start"
                            value="{$data.trait_start}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="trait_end" class="col-md-4 control-label"><span class="red">*</span>{t}Fin :{/t}</label>
                    <div class="col-md-8">
                        <input class="form-control datetimepicker" id="trait_end" name="trait_end"
                            value="{$data.trait_end}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="duration" class="col-md-4 control-label"><span class="red">*</span>
                        {t}Durée (mn) :{/t}</label>
                    <div class="col-md-8">
                        <input class="form-control timepicker" id="duration" name="duration" value="{$data.duration}"
                            required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="maree_coef" class="col-md-4 control-label"><span class="red">*</span>
                        {t}Coefficient de marée :{/t}</label>
                    <div class="col-md-8">
                        <input class="form-control nombre" id="maree_coef" name="maree_coef" value="{$data.maree_coef}"
                            required>
                        <input class="" type="radio" id="maree_id1" name="maree_id" value="1" {if
                            $data.maree_id==1}checked{/if}>&nbsp;{t}marée montante{/t}
                        <input class="" type="radio" id="maree_id2" name="maree_id" value="2" {if
                            $data.maree_id==2}checked{/if}>&nbsp;{t}marée descendante{/t}
                    </div>
                </div>
                <div class="form-group">
                    <label for="engin_type_id" class="col-md-4 control-label"><span class="red">*</span>
                        {t}Engin de pêche :{/t}</label>
                    <div class="col-md-8">
                        <select class="form-control" id="engin_type_id" name="engin_type_id">
                            {foreach $engins as $engin}
                            <option value="{$engin.engin_type_id}" {if
                                $engin.engin_type_id==$data.engin_type_id}selected{/if}>{$engin.engin_type_libelle}
                            </option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="remarks" class="col-md-4 control-label">{t}Commentaires :{/t}</label>
                    <div class="col-md-8">
                        <textarea class="form-control" id="remarks" name="remarks">{$data.remarks}</textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label for="manipulateurs" class="col-md-4 control-label">{t}Manipulateurs :{/t}</label>
                    <div class="col-md-8">
                        {foreach $manipulateurs as $manip}
                        {if $manip.actif == 1 || $manip.trait_id > 0}
                        <div class="col-md-4" id="manipulateurs">
                            <input type="checkbox" name="manipulateur[]" value="{$manip.manipulateur_id}" {if
                                $manip.trait_id> 0}checked{/if}>&nbsp;{$manip.firstname} {$manip.name}
                        </div>
                        {/if}
                        {/foreach}
                    </div>
                </div>
            </fieldset>
            <fieldset>
                <legend>{t}Coordonnées géographiques du trait{/t}</legend>
                <div class="form-group">
                    <label for="pos_deb_lat" class="control-label col-md-4">
                        {t}Point de début :{/t}
                    </label>
                    <div class="col-md-8" id="pos_deb">
                        <table class="tablesaisie">
                            <tr>
                                <th></th>
                                <th>En degrés-minutes</th>
                                <th>En valeur numérique</th>
                            </tr>
                            <tr>
                                <td>{t}Lat :{/t}</td>
                                <td>
                                    <input class="gps_source" name="pos_deb_lat" id="pos_deb_lat" value=""
                                        placeholder="45°01,234N" autocomplete="off">
                                </td>
                                <td><input class="taux  gps startpoint" name="latitude_start" id="pos_deb_lat_dd"
                                        value="{$data.latitude_start}" autocomplete="off"></td>
                            </tr>
                            <tr>
                                <td>{t}Lon :{/t}</td>
                                <td>
                                    <input class="gps_source" name="pos_deb_lon" id="pos_deb_lon" value=""
                                        placeholder="01°10,234W" autocomplete="off">
                                </td>
                                <td><input class="taux gps startpoint" name="longitude_start" id="pos_deb_lon_dd"
                                        value="{$data.longitude_start}" autocomplete="off"></td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="form-group">
                    <label for="pos_fin" class="control-label col-md-4">
                        {t}Point de fin :{/t}
                    </label>
                    <div class="col-md-8" id="pos_fin">
                        <table class="tablesaisie">
                            <tr>
                                <td>{t}Lat :{/t}</td>
                                <td>
                                    <input class="gps_source" name="pos_fin_lat" id="pos_fin_lat" value=""
                                        placeholder="45°01,234N" autocomplete="off">
                                </td>
                                <td><input class="taux  gps endpoint" name="latitude_end" id="pos_fin_lat_dd"
                                        value="{$data.latitude_end}" autocomplete="off"></td>
                            </tr>
                            <tr>
                                <td>{t}Lon :{/t}</td>
                                <td>
                                    <input class="gps_source" name="pos_fin_lon" id="pos_fin_lon" value=""
                                        placeholder="01°10,234W" autocomplete="off">
                                </td>
                                <td><input class="taux  gps endpoint" name="longitude_end" id="pos_fin_lon_dd"
                                        value="{$data.longitude_end}" autocomplete="off"></td>
                            </tr>
                        </table>

                    </div>
                </div>
                <div class="form-group">
                    <label for="trait_length" class="col-md-4 control-label">
                        {t}Longueur du trait (milles nautiques) :{/t}</label>
                    <div class="col-md-8">
                        <input class="form-control taux" id="trait_length" name="trait_length"
                            value="{$data.trait_length}" autocomplete="off">
                    </div>
                </div>
            </fieldset>


            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.trait_id > 0 }
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
            {$csrf}
        </form>
    </div>
    <div class="col-md-6">
        {include file="trait/traitMap.tpl"}
    </div>
</div>
<span class="red">*</span><span class="messagebas">{t}Donnée obligatoire{/t}</span>