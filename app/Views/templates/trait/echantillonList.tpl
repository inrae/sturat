
{if $rights.manage == 1 && $readOnly == 0 }
  <div class="col-md-6">
    <a href="echantillonChange?trait_id={$trait.trait_id}&echantillon_id=0">
    <img src="display/images/new.png" height="25">
    {t}Nouvel échantillon{/t}
    </a>
  </div>
{/if}

<div class="col-lg-12">
  <table id="echantillonList" class="table table-bordered table-hover datatable-nopaging ">
    <thead>
      <tr>
        <th>{t}Id{/t}</th>
        <th>{t}Espèce{/t}</th>
        <th>{t}Nbre total{/t}</th>
        <th>{t}Poids total mesuré{/t}</th>
        <th>{t}Poids total estimé{/t}</th>
        <th>{t}Nbre de poissons mesurés{/t}</th>
        <th>{t}Nbre de poissons morts{/t}</th>
        <th>{t}Nbre de poissons conservés pour d'autres manips{/t}</th>
        <th>{t}Destination{/t}</th>
      </tr>
    </thead>
    <tbody>
      {foreach $samples as $sample}
        <tr>
          <td class="center">{$sample.echantillon_id}</td>
          <td>
            <a href="echantillonChange?echantillon_id={$sample.echantillon_id}&trait_id={$trait.trait_id}">
              {$sample.nom} <i>{$sample.nom_fr}</i>
            </a>
          </td>
          <td class="center">{$sample.total_number}</td>
          <td class="center">{$sample.weight}</td>
          <td class="center">{$sample.weight_comment}</td>
          <td class="center">{$sample.total_measured_number}</td>
          <td class="center">{$sample.total_death}</td>
          <td class="center">{$sample.total_sample}</td>
          <td >{$sample.sample_comment}</td>
        </tr>
      {/foreach}
    </tbody>
  </table>
</div>
