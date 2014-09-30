#import arcpy module
import arcpy

#License file is specific for city of avl.  you will need to acquire your own license file and change the database_name.  this is for automation.
arcpy.CreateEnterpriseGeodatabase_management(database_platform="PostgreSQL",instance_name="localhost",database_name="coagis",account_authentication="DATABASE_AUTH",database_admin="postgres",database_admin_password="postgres",sde_schema="SDE_SCHEMA",gdb_admin_name="sde",gdb_admin_password="E$ri3774",tablespace_name="#",authorization_file="/home/arcgis/undefined-2017.respc")
