import pandas as pd
import math

def manipula_dados(data_table):
    print("Manipulando CSV")
    try:
        lista_de_resultados = []
        for linha in data_table.itertuples(index=False):
            if pd.notna(linha.Matrícula):
                manipulado = str(linha.Matrícula)
                partes = manipulado.split('.',1) #separa 1 vez para baseado no '.'
                if len(partes) == 2:
                    nome,sobrenome = partes #separa uma parte para cada tupula
                    nome_completo = (nome,sobrenome,manipulado) #cria tupula final
                    print(nome_completo)
                    lista_de_resultados.append(nome_completo)
        df_final = pd.DataFrame(lista_de_resultados,columns=['PrimeiroNome','Sobrenome','Login'])
        return df_final
    except ValueError as e:
        print(f'ERRO NA MANIPULACAO DE DADOS :{e}')
            
        
            
        


   

