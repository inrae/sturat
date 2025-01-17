<h2>{t}Recherche des esturgeons lâchés ou capturés{/t}</h2>
<div class="row">
    <div class="col-lg-6">
        <form class="form-horizontal " id="traitSearch" action="sturioList" method="GET">
            <input type="hidden" name="isSearch" value="1">
            <div class="form-group">
                <label for="search_type" class="col-md-2 control-label">{t}Champ de recherche :{/t}</label>
                <div class="col-md-2">
                    <select id="search_type" name="search_type" class="form-control">
                        <option value="pittag" {if $dataSearch.search_type=="pittag" }selected{/if}>{t}Pittag{/t}
                        </option>
                        <option value="hp_tag" {if $dataSearch.search_type=="hp_tag" }selected{/if}>{t}HP Tag{/t}
                        </option>
                        <option value="dst_tag" {if $dataSearch.search_type=="dst_tag" }selected{/if}>{t}DST Tag{/t}
                        </option>
                    </select>
                </div>
                <label for="pittag" class="col-md-2 control-label">{t}N° à chercher (entier ou partiel) :{/t}</label>
                <div class="col-md-2">
                    <input class="form-control" id="pittag" name="pittag" value="{$dataSearch.pittag}">
                </div>
                <div class="col-md-4 center">
                    <input type="submit" class="btn btn-success" value="{t}Rechercher{/t}">
                </div>
            </div>
            {$csrf}
        </form>
    </div>
</div>
{if $isSearch == 1}
<div class="row">
    <div class="col-lg-8">
        <table id="sturioList" class="table table-bordered table-hover datatable " data-order='[[0, "asc"],[3,"desc"]]'>
            <thead>
                <tr>
                    <th>{t}Pittag{/t}</th>
                    <th>{t}HP Tag{/t}</th>
                    <th>{t}DST Tag{/t}</th>
                    <th>{t}Date{/t}</th>
                    <th>{t}Type{/t}</th>
                    <th>{t}Station{/t}</th>
                    <th>{t}Cohorte{/t}</th>
                    <th>{t}Longueur totale{/t}</th>
                    <th>{t}Longueur fourche{/t}</th>
                    <th>{t}Masse{/t}</th>
                </tr>
            </thead>
            <tbody>
                {foreach $data as $row}
                <tr>
                    <td class="center">
                        <a
                            href="sturioDetail?individu_sturio_id={$row.individu_sturio_id}&pittag={$row.pittag}&hp_tag={$row.hp_tag}">
                            {$row.pittag}
                        </a>
                    </td>
                    <td class="center">
                        <a
                            href="sturioDetail?individu_sturio_id={$row.individu_sturio_id}&pittag={$row.pittag}&hp_tag={$row.hp_tag}">
                            {$row.hp_tag}
                        </a>
                    </td>
                    <td class="center">{$row.dst_tag}</td>
                    <td class="center">{$row.poisson_date}</td>
                    <td class="center">{$row.poisson_type}</td>
                    <td class="center">{$row.localisation}</td>
                    <td class="center">{$row.cohorte}</td>
                    <td class="right">{$row.total_length}</td>
                    <td class="right">{$row.fork_length}</td>
                    <td class="right">{$row.weight}</td>
                </tr>
                {/foreach}
            </tbody>
        </table>
    </div>
</div>
{/if}