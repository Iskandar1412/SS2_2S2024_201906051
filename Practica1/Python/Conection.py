import pyodbc
import logging
import subprocess
import os
import shutil
import csv

from Consults import Consultas

# C:\Users\Pacos\Desktop\Proyectos\SS2_2S2024_201906051\Practica1\Pruebas\DataSet.csv

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)
consult = Consultas()

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
        destin = r'C:\CSV\DataSet.csv'
        TempCarga = '../db/SQL/Carga_Temp.sql'
        if os.path.exists(ruta_archivo):
            shutil.copy2(ruta_archivo, destin)

        try:
            conn = pyodbc.connect(connection_string)
            cursor = conn.cursor()

            subprocess.run(['sqlcmd', '-S', server, '-d', database, '-U', user, '-P', password, '-i', TempCarga])
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
        Limpieza = '../db/SQL/Limpieza.sql'
        Carga = '../db/SQL/Carga.sql'
        try:
            conn = pyodbc.connect(connection_string)
            cursor = conn.cursor()
            
            #Se pondra la carga a las tablas con contenido corregido
            subprocess.run(['sqlcmd', '-S', server, '-d', database, '-U', user, '-P', password, '-i', Limpieza])
            conn.commit()
            print('Limpieza Realizada')

            subprocess.run(['sqlcmd', '-S', server, '-d', database, '-U', user, '-P', password, '-i', Carga])
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
        delete_sql = '../db/SQL/Delete_Tables.sql'
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
        path_sql = '../db/SQL/Create_Tables.sql'
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

    def Consultas(self, consul, num, carpeta):
        texto = carpeta + f'/CP{num}.txt'
        with open(texto, 'w', newline='', encoding='utf-8') as file:
            writer = csv.writer(file, delimiter='\t', quoting=csv.QUOTE_MINIMAL)
            number = 1
            for query in consul:
                try:
                    conn = pyodbc.connect(connection_string)
                    cursor = conn.cursor()
                    cursor.execute(query)
                    rows = cursor.fetchall()
                    columns = [desc[0] for desc in cursor.description]
                    file.write(f'--- INIT Consulta {number}\n\n')
                    
                    # if columns[0] != '':
                    #     file.write('\t\t\t'.join(columns) + '\n')
                        
                    # for row in rows:
                    #     row_str = '\t\t\t'.join(str(value) for value in row)
                    #     file.write(row_str + '\n')
                    if columns[0] == '':
                        columns[0] = 'Value'
                    
                    max_widths = [
                        max(len(str(col)), max(len(str(row[i])) for row in rows))
                        for i, col in enumerate(columns)
                    ]

                    formatted_headers = [col.ljust(width) for col, width in zip(columns, max_widths)]
                    writer.writerow(formatted_headers)

                    for row in rows:
                        formatted_row = [str(value).ljust(width) for value, width in zip(row, max_widths)]
                        writer.writerow(formatted_row)

                
                    conn.commit()
                    file.write(f'\n--- END Consulta {number}\n')
                    number += 1
                    conn.close()
                except pyodbc.Error as error:
                    print("Error: No se pudo realizar la consulta. {}".format(error))
                    conn.rollback()
            print(f'Consulta {num} realizada correctamente')
            file.close()

    def GeneracionConsulta(self):
        consult.setConexion(connection_string)
        consult.CrearCarpeta()
        carpeta = consult.carpetaday
        con1 = consult.Consulta1()
        self.Consultas(con1, 1, carpeta)
        consult.Consulta2()
        con1 = consult.Consulta2()
        self.Consultas(con1, 2, carpeta)
        consult.Consulta3()
        con1 = consult.Consulta3()
        self.Consultas(con1, 3, carpeta)
        consult.Consulta4()
        con1 = consult.Consulta4()
        self.Consultas(con1, 4, carpeta)
        consult.Consulta5()
        con1 = consult.Consulta5()
        self.Consultas(con1, 5, carpeta)
        consult.Consulta6()
        con1 = consult.Consulta6()
        self.Consultas(con1, 6, carpeta)
        consult.Consulta7()
        con1 = consult.Consulta7()
        self.Consultas(con1, 7, carpeta)
        consult.Consulta8()
        con1 = consult.Consulta8()
        self.Consultas(con1, 8, carpeta)
        consult.Consulta9()
        con1 = consult.Consulta9()
        self.Consultas(con1, 9, carpeta)
        consult.Consulta10()
        con1 = consult.Consulta10()
        self.Consultas(con1, 10, carpeta)