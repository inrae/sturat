 <script>
  $(document).ready( function () {
    function toDegreesMinutesAndSeconds(coordinate, latlon) {
      if (coordinate.length > 0) {
        var absolute = Math.abs(coordinate);
        var degrees = Math.floor(absolute);
        var minutesNotTruncated = (absolute - degrees) * 60;
        var minutes = Math.floor(minutesNotTruncated);
        var seconds = Math.floor((minutesNotTruncated - minutes) * 60);
        var cardinal = "N";
        if (latlon == "lat") {
          if (coordinate < 0) {
            cardinal = "S";
          }
        } else {
          if (coordinate > 0) {
            cardinal = "E";
          } else {
            cardinal = "W";
          }
        }
      return degrees + " " + minutes + " " + seconds + " " + cardinal;
      }
    }

    /*
    * Initialisation of sexagesimal coordinates
    */
    $("#pos_deb_lat").text(toDegreesMinutes("{$geom.latitude_start}", "lat"));
    $("#pos_deb_long").text(toDegreesMinutes("{$geom.longitude_start}", "lon"));
    $("#pos_fin_lat").text(toDegreesMinutes("{$geom.latitude_end}", "lat"));
    $("#pos_fin_long").text(toDegreesMinutes("{$geom.longitude_end}", "lon"));
  });
 </script>
 <div class="col-md-6">
 {if $rights.manage == 1 && $readOnly == 0 }
    <a href="traitChange?trait_id={$trait.trait_id}">
    <img src="display/images/edit.gif" height="25">
    {t}Modifier les données générales{/t}
    </a>
  {/if}
<div class="form-display">
  <fieldset>
    <legend>{t}Informations générales{/t}</legend>
    <dl class="dl-horizontal">
      <dt>{t}Station :{/t}</dt>
      <dd>{$trait.station_code}</dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>{t}Début :{/t}</dt>
      <dd>{$trait.trait_start}</dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>{t}Fin :{/t}</dt>
      <dd>{$trait.trait_end}</dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>{t}Durée (mn) :{/t}</dt>
      <dd>{$trait.duration}</dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>{t}Coefficient de marée :{/t}</dt>
      <dd>{$trait.maree_coef} - {$trait.maree_libelle}</dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>{t}Engin de pêche :{/t}</dt>
      <dd>{$trait.engin_type_libelle}</dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>{t}Commentaires :{/t}</dt>
      <dd class="textareaDisplay">{$trait.remarks}</dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>{t}Manipulateurs :{/t}</dt>
      <dd>
        {foreach $manipulateurs as $manip}
          {$manip.firstname} {$manip.name}
          <br>
        {/foreach}
      </dd>
    </dl>
  </fieldset>
  <fieldset>
    <legend>{t}Coordonnées géographiques du trait{/t}</legend>
    <dl class="dl-horizontal">
      <dt>{t}Point de début :{/t}</dt>
      <dd>
        Lat : {$geom.latitude_start} (<span id="pos_deb_lat"></span>)
        <br>
        Lon : {$geom.longitude_start} (<span id="pos_deb_long"></span>)
      </dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>{t}Point de fin :{/t}</dt>
      <dd>
        Lat : {$geom.latitude_end} (<span id="pos_fin_lat"></span>)
        <br>
        Lon : {$geom.longitude_end} (<span id="pos_fin_long"></span>)
      </dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>{t}Longueur du trait :{/t}</dt>
      <dd>{$geom.trait_length}</dd>
    </dl>
  </fieldset>
</div>
</div>
<div class="col-md-6">
  {include file="trait/traitMap.tpl"}
</div>
