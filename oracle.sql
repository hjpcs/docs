mvn安装oracle驱动
mvn install:install-file  -DgroupId=com.oracle -DartifactId=ojdbc8 -Dversion=18.0.0.0.0 -Dpackaging=jar -Dfile=E:\driver\ojdbc8.jar

select name from v$datafile;  
--查看数据文件名
create tablespace test datafile 'test.dbf' size 20M autoextend on;  
--创建表空间
create user hjp identified by hjp default tablespace test;  
--创建用户并指定默认表空间
grant connect,resource,dba to hjp;
grant create session to hjp;
--给用户赋权
select instance_name from v$instance;  
--查看数据库实例名
revoke dba from hjp;  
--收回dba权限
select username from dba_users;  
--查看所有用户
drop user hjp cascade;  
--删除用户
select tablespace_name from user_tablespaces where tablespace_name='TEST';  
--查看表空间是否存在
drop tablespace test including contents and datafiles;  
--删除表空间
select table_name from user_tables;  
--查看当前用户的表
select tablespace_name from user_tablespaces;
--查询当前用户拥有的所有表空间
create table temp (stmt varchar(255) default null) tablespace test;
--创建表
drop table temp;
--删除表
select dbms_metadata.get_ddl('TABLE','table_name') from dual;
--查看建表语句

闪回flashback操作
--查看回收站
SELECT * FROM DBA_RECYCLEBIN ORDER BY droptime DESC;
--当前用户的回收站
SELECT * FROM RECYCLEBIN ORDER BY droptime DESC;
--查询SCN与时间的对应关系
select scn,to_char(time_dp,'yyyy-mm-dd hh24:mi:ss') from sys.smon_scn_time ORDER BY time_dp DESC;
--最大/最新的SCN号
SELECT MAX(SCN) FROM sys.smon_scn_time;
--查询当前的SCN
select current_scn from v$database;

--将表的行移动权限打开
alter table test enable row movement;
alter table testbak enable row movement;
alter table testbakk enable row movement;
alter table testbakkk enable row movement;
--查看当前数据库scn并保存
select current_scn from v$database;
--执行sql语句进行修改表数据
insert into test values(1,2,3,4,5);
delete from testbak where a=10 or b=21;
update testbakk set a=100 where c=32 or d=43;
delete from testbakkk;
--执行flashback操作还原数据
flashback table test to scn 5976071331885;
flashback table testbak to scn 5976071331885;
flashback table testbakk to scn 5976071331885;
flashback table testbakkk to scn 5976071331885;