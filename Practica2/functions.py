# pip install pandas numpy matplotlib nltk spacy
import pandas as pd
import numpy as np
import re
import matplotlib.pyplot as plt

def limpiar_course_title(title):
    # Eliminar caracteres especiales y convertir a minúsculas
    title = re.sub(r'[^\w\s]', '', title)
    title = title.lower()
    return title

def limpiar_rating(rating):
    # Convertir a número flotante si es posible, de lo contrario, devolver None
    try:
        return float(rating)
    except ValueError:
        return None

def limpiar_level(level):
    if isinstance(level, str):
        # Convertir a minúsculas y eliminar espacios en blanco extra
        level = level.lower().strip()
        return level
    else:
        return None
    

def limpiar_duration(duracion):
    if pd.isna(duracion):
        return duracion
    
    # Buscar patrones comunes utilizando expresiones regulares
    minutos_patron = re.compile(r'(\d+)\s*(?:minute|min)')
    horas_patron = re.compile(r'(\d+)\s*hour')
    meses_patron = re.compile(r'(\d+) months? at (\d+) hours a week')
    
    total_horas = 0

    # Convertir meses a horas
    meses_coincidencia = meses_patron.findall(duracion)
    if meses_coincidencia:
        horas_por_mes = int(meses_coincidencia[0][0]) * int(meses_coincidencia[0][1]) * 4
        total_horas += horas_por_mes

    else:

        # Buscar y sumar los minutos en el texto
        minutos = minutos_patron.findall(duracion)
        if minutos:
            total_horas += round(float(minutos[0]) / 60, 2)
        
        # Buscar y sumar las horas en el texto
        horas_coincidencia = horas_patron.findall(duracion)
        if horas_coincidencia:
            total_horas += int(horas_coincidencia[0])
    
    return total_horas

    
def limpiar_schedule(schedule):
    try:
        # Si el valor es 'Flexible schedule', se retorna 'Flexible'
        if schedule == 'Flexible schedule':
            return 'Flexible'
        # Si no, se retorna el valor original
        else:
            return schedule
    except Exception as e:
        print(f"Error al limpiar el campo 'Schedule': {e}")
        return None

def limpiar_review(review):
    try:
        # Verificar si el valor es una cadena de texto
        if isinstance(review, str):
            # Encontrar la palabra "reviews" en el texto
            index = review.find('reviews')
            if index != -1:
                # Obtener el substring desde el inicio hasta el índice de "reviews"
                review_number = review[:index].strip()
                # Convertir el substring a entero y retornarlo
                return int(review_number.replace(',', ''))
            else:
                # Si no se encuentra "reviews", retornar None
                return None
        else:
            # Si el valor no es una cadena de texto, retornar None
            return None
    except Exception as e:
        print(f"Error al limpiar el campo 'Review': {e}")
        return None

def limpiar_keyword(keyword):
    try:
        # Convertir a minúsculas y eliminar espacios en blanco extra
        keyword = keyword.lower().strip()
        return keyword
    except Exception as e:
        print(f"Error al limpiar el campo 'Keyword': {e}")
        return None

def validar_registro(df):
    campos_obligatorios = ['Course Title', 'Rating', 'Level', 'Duration', 'Schedule', 'Review', 'Keyword']
    df_valido = df.copy()  
    for campo in campos_obligatorios:
        df_valido = df_valido[df_valido[campo].notnull()]  
    return df_valido

def promedio_calificaciones(df):
    # Calcular el promedio de las calificaciones por curso
    promedio_df = df.groupby('Course Title')['Rating'].mean().reset_index()

    # Renombrar la columna 'Rating' a 'Promedio Calificaciones'
    promedio_df.rename(columns={'Rating': 'Promedio Calificaciones'}, inplace=True)

    return promedio_df

def cursos_mayor_menor_rating(df):
    # Encontrar el rating máximo y mínimo
    max_rating = df['Rating'].max()
    min_rating = df['Rating'].min()

    # Filtrar los cursos con el rating máximo y mínimo
    cursos_max_rating = df[df['Rating'] == max_rating][['Course Title', 'Rating']]
    cursos_min_rating = df[df['Rating'] == min_rating][['Course Title', 'Rating']]

    # Cambiar los índices para reflejar el orden de los cursos
    cursos_max_rating.reset_index(drop=True, inplace=True)
    cursos_min_rating.reset_index(drop=True, inplace=True)

    # Crear un DataFrame con los cursos y su rating correspondiente
    df_max = pd.DataFrame({'Curso': cursos_max_rating['Course Title'], 'Rating': max_rating})
    df_min = pd.DataFrame({'Curso': cursos_min_rating['Course Title'], 'Rating': min_rating})

    return df_max, df_min

def calcular_porcentaje_horario_flexible(df):
    # Contar el número de cursos con horario flexible
    cursos_flexibles = df[df['Schedule'] == 'Flexible'].shape[0]
    
    # Contar el número total de cursos con un valor en el campo 'Schedule'
    total_cursos_con_schedule = df['Schedule'].notnull().sum()
    
    # Calcular el porcentaje
    if total_cursos_con_schedule > 0:
        porcentaje = (cursos_flexibles / total_cursos_con_schedule) * 100
        porcentaje_redondeado = round(porcentaje, 2)
        return porcentaje_redondeado
    else:
        return 0
    
def grafica_nivel_dificultad(df):
    # Contar el número de cursos en cada nivel de dificultad
    conteo_niveles = df['Level'].value_counts().sort_index()
    
    # Colores personalizados para cada nivel de dificultad
    colores = ['skyblue', 'lightgreen', 'orange', 'salmon']
    
    # Crear la gráfica de barras
    plt.figure(figsize=(10, 6))
    bars = plt.bar(conteo_niveles.index, conteo_niveles.values, color=colores)
    
    # Añadir etiquetas y título
    plt.xlabel('Nivel de Dificultad')
    plt.ylabel('Número de Cursos')
    plt.title('Número de Cursos en Cada Nivel de Dificultad')
    
    # Añadir el número de cursos en cada barra
    for bar in bars:
        height = bar.get_height()
        plt.text(bar.get_x() + bar.get_width() / 2, height, height,
                ha='center', va='bottom')
    
    # Mostrar la gráfica
    plt.tight_layout()
    plt.show()

def grafica_categorias(df, top_n=5):
    # Contar el número de cursos en cada categoría
    conteo_categorias = df['Keyword'].explode().value_counts().nlargest(top_n).sort_values(ascending=True)
    
    # Colores personalizados para las barras
    colores = ['lightblue', 'lightgreen', 'orange', 'salmon', 'lightcoral']
    
    # Crear la gráfica de barras horizontales
    plt.figure(figsize=(10, 6))
    bars = plt.barh(conteo_categorias.index, conteo_categorias.values, color=colores)
    
    # Añadir etiquetas y título
    plt.xlabel('Número de Cursos')
    plt.ylabel('Categoría')
    plt.title(f'Principales {top_n} Categorías de Cursos')
    
    # Añadir el número de cursos en cada barra
    for bar in bars:
        width = bar.get_width()
        plt.text(width, bar.get_y() + bar.get_height() / 2, width,
                 ha='left', va='center')
    
    # Mostrar la gráfica
    plt.tight_layout()
    plt.show()


def grafica_dispersion(df):
    # Filtrar los cursos con duración y número de reseñas no nulos
    df_filtrado = df.dropna(subset=['Duration', 'Review'])
    
    # Crear la gráfica de dispersión
    plt.figure(figsize=(10, 6))
    plt.scatter(df_filtrado['Duration'], df_filtrado['Review'], alpha=0.7, color='orange')
    
    # Añadir etiquetas y título
    plt.xlabel('Duración del Curso (horas)', fontsize=12)
    plt.ylabel('Número de Reseñas', fontsize=12)
    plt.title('Relación entre Duración del Curso y Número de Reseñas', fontsize=14)
    
    # Añadir una línea de tendencia (regresión lineal) opcional
    m, b = np.polyfit(df_filtrado['Duration'], df_filtrado['Review'], 1)
    plt.plot(df_filtrado['Duration'], m*df_filtrado['Duration'] + b, color='red')
    
    # Mostrar la gráfica
    plt.grid(True)
    plt.tight_layout()
    plt.show()

def histograma_duraciones(df):
    # Filtrar los cursos con duración no nula
    duraciones = df['Duration'].dropna()
    
    # Crear el histograma personalizado
    plt.figure(figsize=(10, 6))
    plt.hist(duraciones, bins=20, color='lightgreen', edgecolor='black', alpha=0.7)
    
    # Añadir etiquetas y título
    plt.xlabel('Duración del Curso (horas)', fontsize=12)
    plt.ylabel('Frecuencia', fontsize=12)
    plt.title('Distribución de Duraciones de los Cursos', fontsize=14)
    
    # Mostrar la gráfica
    plt.grid(True)
    plt.tight_layout()
    plt.show()

def grafico_caja_calificaciones_por_nivel(df):
    # Filtrar los cursos con calificación y nivel de dificultad no nulos
    datos_filtrados = df[['Rating', 'Level']].dropna()

    # Definir colores personalizados para cada nivel de dificultad
    colores = {'Beginner': '#FF5733', 'Intermediate': '#33FFA8', 'Advanced': '#3373FF'}

    # Obtener los niveles de dificultad y sus respectivas calificaciones
    niveles = datos_filtrados['Level'].unique()
    calificaciones_por_nivel = [datos_filtrados[datos_filtrados['Level'] == nivel]['Rating'] for nivel in niveles]

    # Crear el gráfico de caja
    plt.figure(figsize=(10, 6))
    cajas = plt.boxplot(calificaciones_por_nivel, labels=niveles, patch_artist=True)

    # Asignar colores a las cajas
    for caja, color in zip(cajas['boxes'], colores.values()):
        caja.set_facecolor(color)

    # Añadir etiquetas y título
    plt.xlabel('Nivel de Dificultad del Curso', fontsize=12)
    plt.ylabel('Calificación', fontsize=12)
    plt.title('Distribución de Calificaciones por Nivel de Dificultad', fontsize=14)

    # Personalizar ejes y cuadrícula
    plt.xticks(fontsize=10)
    plt.yticks(fontsize=10)
    plt.grid(axis='y', linestyle='--', alpha=0.7)

    # Ajustar diseño
    plt.tight_layout()

    # Mostrar la gráfica
    plt.show()
