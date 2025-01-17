<a href="sturioList"><img src="display/images/list.png" height="25">{t}Retour à la liste{/t}</a>
<h2>Détail des informations sur le poisson</h2>
{if !empty($poisson.matricule)}
  <div class="row">
    <div class="col-lg-6 col-sm-8">
      <fieldset >
        <legend>{t}Données d'élevage{/t}</legend>
        <div class="form-display">
          <dl class="dl-horizontal">
            <dt>{t}Matricule et prénom :{/t}</dt>
            <dd>{$poisson.matricule} {$poisson.prenom}</dd>
          </dl>
          <dl class="dl-horizontal">
            <dt>{t}Marques posées :{/t}</dt>
            <dd>{$poisson.pittag_valeur}</dd>
          </dl>
          <dl class="dl-horizontal">
            <dt>{t}Date de naissance et cohorte :{/t}</dt>
            <dd>{$poisson.date_naissance} - {$poisson.cohorte}</dd>
          </dl>
          <dl class="dl-horizontal">
            <dt>{t}Commentaire :{/t}</dt>
            <dd class="textarea-display">{$poisson.commentaire}</dd>
          </dl>
          <dl class="dl-horizontal">
            <dt>{t}Père(s) :{/t}</dt>
            <dd>{$poisson.peres}</dd>
          </dl>
          <dl class="dl-horizontal">
            <dt>{t}Mère :{/t}</dt>
            <dd>{$poisson.mere}</dd>
          </dl>
          <dl class="dl-horizontal">
            <dt>{t}Date et lieu de lâcher :{/t}</dt>
            <dd>{$poisson.sortie_date} {$poisson.localisation}</dd>
          </dl>
        </div>
      </fieldset>
    </div>
  </div>
{/if}
{if count($sturios) > 0}
  <div class="col-lg-12">
    <div class="row">
      <fieldset >
        <legend>{t}Données de capture{/t}</legend>
        <table id="sturioList" class="table table-bordered table-hover datatable-nopaging-nosearching " data-order='[[0, "desc"]]'>
          <thead>
            <tr>
              <th>{t}Date{/t}</th>
              <th>{t}Station{/t}</th>
              <th>{t}Pittag (implanté){/t}</th>
              <th>{t}Hp (implanté){/t}</th>
              <th>{t}DST (implanté){/t}</th>
              <th>{t}Cohorte et age{/t}</th>
              <th>{t}Longueur totale{/t}</th>
              <th>{t}Longueur fourche{/t}</th>
              <th>{t}Masse{/t}</th>
              <th>{t}Traitement tétracycline{/t}</th>
              <th>{t}Présence parasites{/t}</th>
              <th>{t}Commentaires{/t}</th>
              <th>{t}Père{/t}</th>
              <th>{t}Mère{/t}</th>
            </tr>
          </thead>
          <tbody>
            {foreach $sturios as $sturio}
            <tr>
              <td>{$sturio.trait_start}</td>
              <td>{$sturio.station_code}</td>
              <td>{$sturio.pittag}{if !empty($sturio.implanted_pittag)} (imp.){/if}</td>
              <td>{$sturio.hp_tag}{if !empty($sturio.implanted_hp_tag)} (imp.){/if}</td>
              <td>{$sturio.dst_tag}{if !empty($sturio.implanted_dst_tag)} (imp.){/if}</td>
              <td>{$sturio.cohort}{if !empty($sturio.age)} - {$sturio.age} {t}ans{/t}{/if}</td>
              <td class="right">{$sturio.total_length}</td>
              <td class="right">{$sturio.fork_length}</td>
              <td class="right">{$sturio.weight}</td>
              <td class="center">{if $sturio.tetracycline_treatment == 1}{t}oui{/t}{/if}</td>
              <td class="center">{if $sturio.parasite == 1}{t}oui{/t}{/if}</td>
              <td class="textarea-display">{$sturio.comment}</td>
              <td>{$sturio.father} {$sturio.father_firstname}</td>
              <td>{$sturio.mother} {$sturio.mother_firstname}</td>
            </tr>
            {/foreach}
          </tbody>
        </table>
      </fieldset>
    </div>
  </div>
{/if}
{if count($samplings) > 0}
  <div class="row">
    <div class="col-lg-8">
      <fieldset >
        <legend>{t}Prélèvements effectués{/t}</legend>
        <table id="samplingList" class="table table-bordered table-hover datatable-nopaging-nosearching " data-order='[[0, "desc"]]'>
          <thead>
            <tr>
              <th>{t}Date{/t}</th>
              <th>{t}Type{/t}</th>
              <th>{t}Référence{/t}</th>
              <th>{t}Nageoire{/t}</th>
              <th>{t}Qté de sang{/t}</th>
              <th>{t}Prélèvement de mucus{/t}</th>
              <th>{t}Localisation du prélèvement{/t}</th>
              <th>{t}Commentaire{/t}</th>
            </tr>
            </thead>
          <tbody>
            {foreach $samplings as $sampling}
            <tr>
              <td>{$sampling.trait_start}</td>
              <td>{$sampling.prelevement_type_name}</td>
              <td>{$sampling.prelevement_ref}</td>
              <td>{$sampling.fin_name}</td>
              <td class="right">{$sampling.blood_quantity}</td>
              <td class="center">{if $sampling.mucus_sampling == 1}{t}oui{/t}{/if}</td>
              <td>{$sampling.prelevement_localisation_name}</td>
              <td class="textarea-display">{$sampling.prelevement_comment}</td>
            </tr>
            {/foreach}
          </tbody>
        </table>
      </fieldset>
    </div>
  </div>
{/if}
{if count($measures)>0}
  <div class="row">
    <div class="col-lg-6">
      <fieldset >
        <legend>{t}Mesures effectuées{/t}</legend>
        <table id="measureList" class="table table-bordered table-hover datatable " data-order='[[0, "desc"]]'>
          <thead>
            <tr>
              <th>{t}Date{/t}</th>
              <th>{t}Origine{/t}</th>
              <th>{t}Longueur totale{/t}</th>
              <th>{t}Longueur fourche{/t}</th>
              <th>{t}Masse{/t}</th>
            </tr>
          </thead>
          <tbody>
            {foreach $measures as $measure}
            <tr>
              <td>{$measure.measure_date}</td>
              <td>{$measure.measure_type}</td>
              <td class="right">{$measure.total_length}</td>
              <td class="right">{$measure.fork_length}</td>
              <td class="right">{$measure.weight}</td>
            </tr>
            {/foreach}
          </tbody>
        </table>
      </fieldset>
    </div>
  </div>
{/if}
