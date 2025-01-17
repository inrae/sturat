<script>
  $(document).ready(function () {
    var tabHover = 0;
    try {
      tabHover = Cookies.get("tabHover");
    } catch (Exception) { }
    if (tabHover == 1) {
      $("#tabHoverSelect").prop("checked", true);
    }
    $("#tabHoverSelect").change(function () {
      if ($(this).is(":checked")) {
        tabHover = 1;
      } else {
        tabHover = 0;
      }
      Cookies.set("tabHover", tabHover, { expires: 365, secure: true });
    });
    /* Management of tabs */
    var myStorage = window.localStorage;
    var activeTab = "";
    if (activeTab.length == 0) {
      try {
        activeTab = myStorage.getItem("traitTab");
      } catch (Exception) {
        activeTab = "";
      }
    }
    try {
      if (activeTab.length > 0) {
        $("#" + activeTab).tab('show');
      }
    } catch (Exception) { }
    $('.nav-tabs > li > a').hover(function () {
      if (tabHover == 1) {
        $(this).tab('show');
      }
    });
    $('a[data-toggle="tab"]').on('shown.bs.tab', function () {
      myStorage.setItem("traitTab", $(this).attr("id"));
    });
    $('a[data-toggle="tab"]').on("click", function () {
      tabHover = 0;
    });
  });

</script>
<div class="col-lg-6">
  <a href="traitList"><img src="display/images/list.png" height="25">{t}Retour à la liste{/t}</a>
  {if $rights.manage == 1 && $readOnly == 0 }
    &nbsp;
    <a href="traitChange?trait_id=0">
      <img src="display/images/new.png" height="25">
      {t}Nouveau trait{/t}
    </a>
  {/if}
</div>
<h2>
    {t}Trait n° {/t} {$trait.trait_id} - {t}Station {/t} {$trait.station_code} - {$trait.trait_start}
</h2>
<!--boite d'onglets -->
<div class="row">
  <ul class="nav nav-tabs" id="myTab" role="tablist">
    <li class="nav-item active">
      <a class="nav-link" id="tab-detail" data-toggle="tab" role="tab" aria-controls="nav-detail" aria-selected="true"
        href="#nav-detail">
        <img src="display/images/zoom.png" height="25">
        {t}Détails{/t}
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-lexical="identifier_type" id="tab-phy" href="#nav-phy" data-toggle="tab" role="tab"
        aria-controls="nav-phy" aria-selected="false">
        <img src="display/images/hydrolab.png" height="25">
        {t}Physico-chimie{/t}
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link " data-lexical="identifier_type" id="tab-sample" href="#nav-sample" data-toggle="tab" role="tab"
        aria-controls="nav-sample" aria-selected="false">
        <img src="display/images/poisson.png" height="25">
        {t}Captures{/t}
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link " data-lexical="identifier_type" id="tab-debris" href="#nav-debris" data-toggle="tab" role="tab"
        aria-controls="nav-debris" aria-selected="false">
        <img src="display/images/debris.png" height="25">
        {t}Débris{/t}
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link " data-lexical="identifier_type" id="tab-sturio" href="#nav-sturio" data-toggle="tab" role="tab"
        aria-controls="nav-sturio" aria-selected="false">
        <img src="display/images/sturio.png" height="25">
        {t}Esturgeons{/t}
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link " data-lexical="identifier_type" id="tab-eel" href="#nav-eel" data-toggle="tab" role="tab"
        aria-controls="nav-eel" aria-selected="false">
        <img src="display/images/eel.png" height="25">
        {t}Anguilles{/t}
      </a>
    </li>
  </ul>
  <!-- content of each tab-->
  <div class="tab-content" id="nav-tabContent">
    <div class="tab-pane active in" id="nav-detail" role="tabpanel" aria-labelledby="tab-detail">
      {include file="trait/traitDetail.tpl"}
    </div>
    <div class="tab-pane fade" id="nav-phy" role="tabpanel" aria-labelledby="tab-phy">
      {include file="trait/physicochimieDisplay.tpl"}
    </div>
    <div class="tab-pane fade" id="nav-sample" role="tabpanel" aria-labelledby="tab-sample">
      {include file="trait/echantillonList.tpl"}
    </div>
    <div class="tab-pane fade" id="nav-debris" role="tabpanel" aria-labelledby="tab-debris">
      {include file="trait/traitDebrisList.tpl"}
    </div>
    <div class="tab-pane fade" id="nav-sturio" role="tabpanel" aria-labelledby="tab-sturio">
    {include file="trait/traitSturioList.tpl"}
    </div>
    <div class="tab-pane fade" id="nav-eel" role="tabpanel" aria-labelledby="tab-eel">
    {include file="trait/traitEelList.tpl"}
    </div>
  </div>
  <div class="row">
    <div class="col-sm-12 messageBas">
      {t}Activer le survol des onglets :{/t}
      <input type="checkbox" id="tabHoverSelect">
    </div>
  </div>
</div>
