set search_path = sturat,sturatgacl,public;
alter table dbparam add column dbparam_description varchar;
alter table dbparam add column dbparam_description_en varchar;
create unique index if not exists dbparamname_idx on dbparam (dbparam_name);
insert into dbparam (dbparam_name, dbparam_value, dbparam_description, dbparam_description_en)
values (
'APPLI_code', 
'STURAT',
'Code de l''instance, pour les exportations',
'Code of the instance, to export data'
) 
on conflict do nothing;
alter table acllogin add column if not exists email varchar;
alter table logingestion add column if not exists is_expired boolean;
alter table logingestion add column if not exists nbattempts integer;
alter table logingestion add column if not exists lastattempt datetime;

update aclgroup set groupe = 'manage' where groupe = 'gestion';
update aclaco set aco = 'manage' where aco = 'gestion';
