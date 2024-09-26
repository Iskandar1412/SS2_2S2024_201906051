import nltk
import os

nltk_data_dir = os.path.join(os.getcwd(), 'nltk_data_forced')
nltk.data.path.append(nltk_data_dir)
nltk.download('punkt', download_dir=nltk_data_dir)

import re
from nltk.corpus import stopwords

stop_words = set(stopwords.words('spanish'))

def tokenizar_palabras(texto):
    tokens = re.findall(r'\b\w+\b', texto) 
    tokens_limpios = [word for word in tokens if word.lower() not in stop_words]
    return tokens_limpios

with open('./doc/Comments.txt', 'r', encoding='utf-8') as f:
    for linea in f:
        if linea.strip():
            tokens = tokenizar_palabras(linea)
            print(tokens)