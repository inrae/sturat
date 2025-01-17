{if $rights.manage == 1 && $readOnly == 0 }
  <div class="col-md-6">
    <a href="individuEelChange?trait_id={$trait.trait_id}&individu_eel_id=0">
    <img src="display/images/new.png" height="25">
    {t}Nouvelle anguille{/t}
    </a>
  </div>
{/if}

<div class="col-lg-8">
  <table id="traitEelList" class="table table-bordered table-hover datatable-nopaging ">
    <thead>
      <tr>
        <th>{t}Id{/t}</th>
        <th>{t}Longueur totale (mm){/t}</th>
        <th>{t}Longueur pectorale (mm){/t}</th>
       <th>{t}Diamètre horizontal œil (mm){/t}</th>
       <th>{t}Diamètre vertical œil (mm){/t}</th>
       <th>{t}OI{/t}</th>
       <th>{t}ILN{/t}</th>
       <th>{t}J{/t}</th>
       <th>{t}A{/t}</th>
        <th>{t}Stade{/t}</th>
        <th>{t}Commentaires{/t}</th>
      </tr>
    </thead>
    <tbody>
      {foreach $eels as $eel}
      <tr>
        <td class="center">
          <a href="individuEelChange?trait_id={$trait.trait_id}&individu_eel_id={$eel.individu_eel_id}">
          {$eel.individu_eel_id}
          </a>
        </td>
        <td class="right">{$eel.total_length}</td>
        <td class="right">{$eel.pectoral_length}</td>
        <td class="right">{$eel.hori_diam_eyepiece}</td>
        <td class="right">{$eel.vert_diam_eyepiece}</td>
        <td class="right">{$eel.val_oi}</td>
        <td class="right">{$eel.val_iln}</td>
        <td class="right">{$eel.val_j}</td>
        <td class="right">{$eel.val_a}</td>
        <td class="right"> {$eel.eel_stade_name}</td>
        <td class="textareaDisplay">{$eel.observation}</td>
      </tr>
      {/foreach}
    </tbody>
  </table>
</div>
