alter system set log_archive_dest_1='location= C:\Users\ruben.RUBENYAI-PC\Desktop'
scope=spfile;

ALTER DATABASE BACKUP CONTROLFILE TO 'C:\Users\ruben.RUBENYAI-PC\Desktop' ;
ALTER TABLESPACE tbp_indice BEGIN BACKUP ;
ALTER TABLESPACE tbp_tabla BEGIN BACKUP;
ALTER TABLESPACE SYSTEM BEGIN BACKUP;
