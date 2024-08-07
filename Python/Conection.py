import pyodbc
import logging
import subprocess
import os
import re
import time

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

'''Para Docker (SQL Server Docker Image)'''
# driver = 'ODBC Driver 17 for SQL Server'
# server = 'localhost' # '0.0.0.0'
# user = 'sa'
# password = 'SuperSmash123'
# database = 'master'
'''SQL Server Local Windows'''
# Server=localhost\SQLEXPRESS;Database=master;Trusted_Connection=True;
driver = 'ODBC Driver 17 for SQL Server'
server = 'ISKANDAR\\SQLEXPRESS' # '0.0.0.0' Este caso del server es cuando no es en el mismo puerto o localhost,52006
user = 'sa'
password = 'SuperSmash123'
database = 'PRACTICA1'

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

    # def replace_commas(self, line):
    #     line = re.sub(r',(?=(?:[^"]*"[^"]*")*[^"]*$)', '|', line)
    #     # line = re.sub(r',', '.', line)
    #     line = re.sub(r'\"', '', line)
    #     # line = re.sub(r'\|', ',', line)
    #     line = re.sub(r'\n+', '', line)
    #     return line + '\n'

    # def process_csv(self, input_file, output_file):
    #     with open(input_file, 'r', encoding='utf-8') as infile, open(output_file, 'w', newline='', encoding='utf-8') as outfile:

    #         for line in infile:
    #             modified_line = self.replace_commas(line)
    #             outfile.write(modified_line)
    #     time.sleep(2)

    def CargarInformacion(self):
        
        try:
            conn = pyodbc.connect(connection_string)
            cursor = conn.cursor()
            # with open('C:\\Scripts\\Carga.sql', 'r+') as sql_file:
            subprocess.run(['sqlcmd', '-S', server, '-d', database, '-U', user, '-P', password, '-i', '../db/Carga_Temp.sql'])
            conn.commit()
            print("Información cargada exitosamente")
            conn.close()
        except pyodbc.Error as error:
            print("Error al cargar informacion {}".format(error))
            conn.rollback()

    # Carga por lotes
    # def CargarInformacion(self):
    #     path_csv = r'C:\Users\Pacos\Desktop\Proyectos\SS2_2S2024_201906051\Pruebas\DataSet.csv'
    #     try:
    #         batch_size = 10000
    #         conn = pyodbc.connect(connection_string)
    #         cursor = conn.cursor()
    #         with open(path_csv, "r", encoding='utf-8') as archivo_csv:
    #             lector_csv = csv.reader(archivo_csv)
    #             next(lector_csv)  # Saltar la primera fila (encabezados)
    #             batch = []
    #             for fila in lector_csv:
    #                 PassengerID, FirstName, LastName, Gender, Age, Nationality, AirportName, AirportCountryCode, CountryName, AirportContinent, ContinentName, DepartureDate, ArrivalAirport, PilotName, FlightStatus = fila
    #                 batch.append((PassengerID, FirstName, LastName, Gender, Age, Nationality, AirportName, AirportCountryCode, CountryName, AirportContinent, ContinentName, DepartureDate, ArrivalAirport, PilotName, FlightStatus))
    #                 if len(batch) >= batch_size:
    #                     print(batch)
    #                     cursor.executemany("""
    #                         USE PRACTICA1;
    #                         INSERT INTO FlightTemp (PassengerID, FirstName, LastName, Gender, Age, Nationality, AirportName, AirportCountryCode, CountryName, AirportContinent, ContinentName, DepartureDate, ArrivalAirport, PilotName, FlightStatus)
    #                         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    #                     """, batch)
    #                     conn.commit()
    #                     batch = []
    #             if batch:
    #                 cursor.executemany("""
                        
    #                     INSERT INTO FlightTemp (PassengerID, FirstName, LastName, Gender, Age, Nationality, AirportName, AirportCountryCode, CountryName, AirportContinent, ContinentName, DepartureDate, ArrivalAirport, PilotName, FlightStatus)
    #                     VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    #                 """, batch)
    #                 conn.commit()
    #         conn.close()
    #         print("Información cargada exitosamente")
    #     except pyodbc.Error as error:
    #         print("Error: No se pudo cargar la informacion. {}".format(error))
    #         conn.rollback()
            

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