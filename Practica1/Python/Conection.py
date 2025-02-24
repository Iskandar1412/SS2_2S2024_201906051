import pyodbc
import logging
import subprocess
import os
import shutil
import csv
import datetime

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

    def CargarInformacion(self):
        Limpieza = '../db/SQL/Limpieza.sql'
        Carga = '../db/SQL/Carga.sql'
        try:
            conn = pyodbc.connect(connection_string)
            cursor = conn.cursor()
            
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
       
    def BorrarModelo(self):
        delete_sql = '../db/SQL/Delete_Tables.sql'
        try:
            conn = pyodbc.connect(connection_string)
            cursor = conn.cursor()
            with open(delete_sql, 'r') as file:
                sql_script = file.read()
            
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
                    ahora = datetime.datetime.now()
                    rows = cursor.fetchall()
                    columns = [desc[0] for desc in cursor.description]
                    file.write(f'--- INIT Consulta {number} - {ahora.strftime("%Y-%m-%d %H:%M:%S")}\n\n')
                    
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
        self.Consultas(con1, '01', carpeta)
        consult.Consulta2()
        con1 = consult.Consulta2()
        self.Consultas(con1, '02', carpeta)
        consult.Consulta3()
        con1 = consult.Consulta3()
        self.Consultas(con1, '03', carpeta)
        consult.Consulta4()
        con1 = consult.Consulta4()
        self.Consultas(con1, '04', carpeta)
        consult.Consulta5()
        con1 = consult.Consulta5()
        self.Consultas(con1, '05', carpeta)
        consult.Consulta6()
        con1 = consult.Consulta6()
        self.Consultas(con1, '06', carpeta)
        consult.Consulta7()
        con1 = consult.Consulta7()
        self.Consultas(con1, '07', carpeta)
        consult.Consulta8()
        con1 = consult.Consulta8()
        self.Consultas(con1, '08', carpeta)
        consult.Consulta9()
        con1 = consult.Consulta9()
        self.Consultas(con1, '09', carpeta)
        consult.Consulta10()
        con1 = consult.Consulta10()
        self.Consultas(con1, '10', carpeta)