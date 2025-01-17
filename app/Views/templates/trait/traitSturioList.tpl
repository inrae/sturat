<div class="col-md-12">
  {if $readOnly == 0}
    <a href="individuSturioChange?individu_sturio_id=0&trait_id={$trait.trait_id}">
      <img src="display/images/sturio.png" height="25">
      {t}Nouvel esturgeon{/t}
    </a>
  {/if}
</div>
<div class="col-lg-6">
  <table id="traitSturioList" class="table table-bordered table-hover datatable-nopaging ">
    <thead>
      <tr>
        <th>{t}Id{/t}</th>
        <th>{t}Pittag{/t}</th>
        <th>{t}HP tag{/t}</th>
        <th>{t}DST tag{/t}</th>
        <th>{t}Longueur totale (cm){/t}</th>
        <th>{t}Longueur fourche (cm){/t}</th>
        <th>{t}Poids (g){/t}</th>
        <th>{t}cohorte{/t}</th>
      </tr>
    </thead>
    <tbody>
      {foreach $sturios as $sturio}
      <tr>
        <td class="center">
          <a href="individuSturioChange?individu_sturio_id={$sturio.individu_sturio_id}&trait_id={$trait.trait_id}">
            {$sturio.individu_sturio_id}
          </a>
        </td>
        <td>{$sturio.pittag}</td>
        <td>{$sturio.hp_tag}</td>
        <td>{$sturio.dst_tag}</td>
        <td class="right">{$sturio.total_length}</td>
        <td class="right"> {$sturio.fork_length}</td>
        <td class="right">{$sturio.weight}</td>
        <td class="center">{$sturio.cohorte}</td>
      </tr>
      {/foreach}
    </tbody>
  </table>
</div>
