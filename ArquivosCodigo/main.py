
import pandas as pd
from functionExtracao import extrair_dados_pdf_todas_paginas
import config as config
from functionManipulacao import manipula_dados
from procedmentCSV import Convert_to_CSV



#MAIN PY

if __name__ == "__main__":  
    print("INCIANDO EXTRACAO DO PDF",config.NOME_XLSX," PARA CSV",config.ARQUIVO_CVS,"\n")
    data_table = extrair_dados_pdf_todas_paginas(caminho_excel=config.CAMINHO_EXEL,
                          nome_coluna=config.NOME_COLUNA_ALVO)
    
    data_table =  manipula_dados(data_table)
    Convert_to_CSV(data_table,config.ARQUIVO_CVS)
    


print("FIM PROCESSO")