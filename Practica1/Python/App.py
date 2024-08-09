import os
from Conection import ConexionDB

conn = ConexionDB()
seleccion = 0
while seleccion != 6:
    print("""                 
                    Menu Principal
          """)
    print("""
        1. Borrar Modelo            2. Crear Modelo
        3. Extraer Informacion      4. Cargar Informacion
        5. Realizar Consultas       6. Salida
            """)
    seleccion = input("Iskandar@Iska $ > ")
    if seleccion == "1":
        conn.BorrarModelo()
    elif seleccion == "2":
        conn.CrearModelo()
    elif seleccion == "3":
        ruta = input("Ingrese la ruta del archivo > ")
        conn.ExtraerInformacion(ruta)
    elif seleccion == "4":
        conn.CargarInformacion()
    elif seleccion == "5":
        conn.GeneracionConsulta()
    elif seleccion == "6":
        print("Saliendo del programa")
        print("Juan F. Urbina S. - 201906051")
        break
    else:
        print("Opcion no valida")
