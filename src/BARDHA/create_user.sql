create user poojar identified by password;

grant connect to poojar;

grant create session to poojar;

grant dba to poojar;

create tablespace ts_poojar datafile 'D:\ProgFile\app\oracle\oradata\XE\df_poojar.dbf' size 500M;

alter user poojar default tablespace ts_poojar;