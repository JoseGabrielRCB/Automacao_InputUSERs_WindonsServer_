# function.py (versão para extrair TODAS as páginas)

import tabula
import pandas as pd

def extrair_dados_pdf_todas_paginas(caminho_excel, nome_coluna):
    try:
        tupula_colunas = [nome_coluna]
        df = pd.read_excel(caminho_excel,
                        usecols=tupula_colunas,
                        skiprows=23,
                        header=0,
                        dtype={nome_coluna:str})
      #  print(df)
       # df.to_csv(arquivo_csv,index=True)
        return df
    except FileNotFoundError:
         print(f"ERRO: O arquivo Excel '{caminho_excel}' não foi encontrado.")
    except ValueError as e:
         print(f"ERRO DE VALOR: {e}")
     

