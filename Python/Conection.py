import pyodbc
import logging
import subprocess
import os

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

driver = 'ODBC Driver 17 for SQL Server'
server = 'localhost'
# server = '0.0.0.0'
user = 'sa'
password = 'SuperSmash123'
database = 'master'

connection_string = (
    f"DRIVER={driver};"
    f"SERVER={server};"
    f"DATABASE={database};"
    f"UID={user};"
    f"PWD={password};"
)

try:
    logger.info("Connecting to the database...")
    connection = pyodbc.connect(connection_string)
    logger.info("Connection successful!")

    cursor = connection.cursor()
    cursor.execute("SELECT @@VERSION;")
    row = cursor.fetchone()
    while row:
        print(row)
        row = cursor.fetchone()

except pyodbc.Error as e:
    logger.error(f"Error connecting to the database: {e}")
finally:
    if 'connection' in locals() and connection:
        connection.close()
        logger.info("Connection closed.")

class ConexionDB:

    def ExtraerInformacion(self, ruta_archivo):
        try:
            conn = pyodbc.connect(connection_string)
            cursor = conn.cursor()
            # with open('C:\\Scripts\\Carga.sql', 'r+') as sql_file:
            with open('../db/Carga_Temp.sql', 'r+') as sql_file:
                sql_query = sql_file.read()
                sql_query = sql_query.replace('ruta_entrante', ruta_archivo)
                print(sql_query)

            cursor.execute(sql_query)
            conn.commit()
            print("Información extraida exitosamente")
            conn.close()
        except pyodbc.Error as error:
            print("Error: No se pudo extraer la informacion {}".format(error))
            conn.rollback()


    def CargarInformacion(self):
        path_sql = '../db/Carga_Temp.sql'
        try:
            conn = pyodbc.connect(connection_string)
            cursor = conn.cursor()
            with open(path_sql, 'r') as file:
                sql_script = file.read()
            
            # print(sql_script)
            cursor.execute(sql_script)
            conn.commit()
            print("Información cargada exitosamente")
            conn.close()
        except pyodbc.Error as error:
            print("Error: No se pudo cargar la informacion. {}".format(error))
            conn.rollback()

    def BorrarModelo(self):
        delete_sql = '../db/Delete_Tables.sql'
        try:
            conn = pyodbc.connect(connection_string)
            cursor = conn.cursor()
            with open(delete_sql, 'r') as file:
                sql_script = file.read()
            
            # print(sql_script)
            cursor.execute(sql_script)
            conn.commit()
            print("Modelo eliminado exitosamente")
            conn.close()
        except pyodbc.Error as error:
            print("Error: No se pudo eliminar el modelo. {}".format(error))
            conn.rollback()

    def CrearModelo(self):
        path_sql = '../db/Create_Tables.sql'
        try:
            conn = pyodbc.connect(connection_string)
            cursor = conn.cursor()
            with open(path_sql, 'r') as file:
                sql_script = file.read()
            
            # print(sql_script)
            cursor.execute(sql_script)
            conn.commit()
            print("Modelo creado exitosamente")
            conn.close()
        except pyodbc.Error as error:
            print("Error: No se pudo crear el modelo. {}".format(error))
            conn.rollback()