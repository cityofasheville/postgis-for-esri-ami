#import arcpy module
import arcpy

arcpy.CreateEnterpriseGeodatabase_management(database_platform="PostgreSQL",instance_name="localhost",database_name="coagis",account_authentic
ation="DATABASE_AUTH",database_admin="postgres",database_admin_password="postgres",sde_schema="SDE_SCHEMA",gdb_admin_name="sde",gdb_admin_pass
word="E$ri3774",tablespace_name="#",authorization_file="/home/arcgis/undefined-2017.respc")
arcgis@ip-10-153-181-187:~$ /arcgis/server/tools/python addnewsde.py 
