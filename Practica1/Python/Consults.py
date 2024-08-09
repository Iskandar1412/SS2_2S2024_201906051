import pyodbc
import os
from datetime import datetime
import re

def splita(script):
    listacomp = script.split(';')
    listaenviar = listacomp[:-1]
    for i in range(len(listaenviar)):
        listaenviar[i] += ";"
    return listaenviar

def querys(sql_script):
    pattern = r'--.*$|/\*.*?\*/|\n'
    sql_script = re.sub(pattern, ' ', sql_script, flags=re.MULTILINE)
    return splita(sql_script)

class Consultas:
    def __init__(self):
        self.con = None
        self.carpetaday = None
    
    def setConexion(self, conexion):
        self.con = conexion

    def CrearCarpeta(self):
        now = datetime.now().strftime('%m-%d')
        route = f'../Reports/{now}'
        self.carpetaday = route
        try:
            os.makedirs(route)
            print(f'                                Carpeta "{route}" creada exitosamente')
        except FileExistsError:
            print(f'                                Carpeta "{route}" ya existente')

    def Consulta1(self):
        query_sql = '../db/SQL/Consultas/Consulta-01.sql'     
        with open(query_sql, 'r') as file:
            sql_script = file.read()
            queryes = querys(sql_script)
            return queryes    
        
    def Consulta2(self):
        query_sql = '../db/SQL/Consultas/Consulta-02.sql'
        with open(query_sql, 'r') as file:
            sql_script = file.read()
            queryes = querys(sql_script)
            return queryes 
    
    def Consulta3(self):
        query_sql = '../db/SQL/Consultas/Consulta-03.sql'
        with open(query_sql, 'r') as file:
            sql_script = file.read()
            queryes = querys(sql_script)
            return queryes 

    def Consulta4(self):
        query_sql = '../db/SQL/Consultas/Consulta-04.sql'
        with open(query_sql, 'r') as file:
            sql_script = file.read()
            queryes = querys(sql_script)
            return queryes 

    def Consulta5(self):
        query_sql = '../db/SQL/Consultas/Consulta-05.sql'
        with open(query_sql, 'r') as file:
            sql_script = file.read()
            queryes = querys(sql_script)
            return queryes 
    
    def Consulta6(self):
        query_sql = '../db/SQL/Consultas/Consulta-06.sql'
        with open(query_sql, 'r') as file:
            sql_script = file.read()
            queryes = querys(sql_script)
            return queryes 

    def Consulta7(self):
        query_sql = '../db/SQL/Consultas/Consulta-07.sql'
        with open(query_sql, 'r') as file:
            sql_script = file.read()
            queryes = querys(sql_script)
            return queryes 

    def Consulta8(self):
        query_sql = '../db/SQL/Consultas/Consulta-08.sql'
        with open(query_sql, 'r') as file:
            sql_script = file.read()
            queryes = querys(sql_script)
            return queryes 

    def Consulta9(self):
        query_sql = '../db/SQL/Consultas/Consulta-09.sql'
        with open(query_sql, 'r') as file:
            sql_script = file.read()
            queryes = querys(sql_script)
            return queryes 

    def Consulta10(self):
        query_sql = '../db/SQL/Consultas/Consulta-10.sql'
        with open(query_sql, 'r') as file:
            sql_script = file.read()
            queryes = querys(sql_script)
            return queryes 