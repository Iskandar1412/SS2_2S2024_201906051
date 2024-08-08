import csv
def contar_columnas_csv(archivo_csv):
    num_lineas_totales = 0
    num_lineas_15_columnas = 0
    lineas_con_error = []

    try:
        with open(archivo_csv, 'r', encoding='utf-8') as csvfile:
            reader = csv.reader(csvfile, delimiter=',')
            for num_linea, fila in enumerate(reader, 1):
                num_columnas = len(fila)
                num_lineas_totales += 1
                if num_columnas == 15:
                    num_lineas_15_columnas += 1
                else:
                    lineas_con_error.append(num_linea)

    except FileNotFoundError as e:
        print(f"Error: Archivo no encontrado: {archivo_csv}")
        return 0, 0, []

    return num_lineas_totales, num_lineas_15_columnas, lineas_con_error

archivo = "C:\\CSV\\mod.csv"
total, correctas, incorrectas = contar_columnas_csv(archivo)

print(f"Total de líneas: {total}")
print(f"Líneas con 15 columnas: {correctas}")
print(f"Líneas con un número de columnas diferente: {incorrectas}")