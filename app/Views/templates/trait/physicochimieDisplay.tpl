<div class="col-md-6">
{if $rights.manage == 1 && $readOnly == 0 }
    <a href="physicochimieChange?trait_id={$trait.trait_id}">
    <img src="display/images/edit.gif" height="25">
    {t}Modifier les données physico-chimiques{/t}
    </a>
  {/if}
  <div class="form-display">
    <dl class="dl-horizontal">
      <dt>{t}Température (°C) :{/t}</dt>
      <dd>{$phychim.temperature}</dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>{t}Conductivité (mS/cm) :{/t}</dt>
      <dd>{$phychim.conductivity}</dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>{t}Conductivité spécifique à 25 °C, en mS/cm :{/t}</dt>
      <dd>{$phychim.conductivity_specific}</dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>{t}Salinité :{/t}</dt>
      <dd>{$phychim.salinity}</dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>{t}Profondeur (m) :{/t}</dt>
      <dd>{$phychim.depth}</dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>{t}Profondeur de mesure de la sonde :{/t}</dt>
      <dd>{$phychim.depth_probe}</dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>{t}Oxygene, en % de saturation :{/t}</dt>
      <dd>{$phychim.oxygen_ppt}</dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>{t}Oxygene, en mg/l :{/t}</dt>
      <dd>{$phychim.oxygen_mgl}</dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>{t}Turbidité, en NTU :{/t}</dt>
      <dd>{$phychim.turbidity}</dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>{t}pH :{/t}</dt>
      <dd>{$phychim.ph}</dd>
    </dl>
    <dl class="dl-horizontal">
      <dt>{t}Commentaires :{/t}</dt>
      <dd class="textareaDisplay">{$phychim.comment}</dd>
    </dl>
  </div>
</div>
