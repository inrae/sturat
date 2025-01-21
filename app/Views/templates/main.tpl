{if $readOnly == 1}
  <div class="row">
    <div class="center">
      <span class="red">{t}mode en LECTURE SEULE{/t}</span>
    </div>
  </div>
{/if}
{if is_array($rights) && $rights.param == 1}
  <div class="row">
    <div class="col-md-6 col-md-offset-3">
      <form class="form-horizontal" id="paramForm" method="post" action="index.php">
        <input type="hidden" name="module" value="readOnlyChange">
        <div class="form-group">
          <label for="readOnly" class="control-label col-md-4">{t}Mode lecture seule :{/t}</label>
          <div class="col-md-4">
            <input type="radio" id="readOnly0" name="readOnly" value="0" {if $readOnly == 0}checked{/if}>&nbsp;{t}non{/t}
            <input type="radio" id="readOnly1" name="readOnly" value="1" {if $readOnly == 1}checked{/if}>&nbsp;{t}oui{/t}
          </div>
          <div class="col-md-2">
            <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
          </div>
        </div>
      </form>
    </div>
  </div>
{/if}
<div class="row">
  <div class="center">
    <img src="display/images/esturial.png">
  </div>
</div>