# Automação para Criação de Usuários no Active Directory

Este projeto automatiza a criação de múltiplos usuários no Active Directory (AD) a partir de uma lista de alunos em um arquivo Excel. O processo é dividido em duas etapas principais: a preparação dos dados com scripts Python e a criação dos usuários com um script PowerShell.

### Visão Geral do Processo

1.  **Extração e Formatação (Python):**

      * Um conjunto de scripts Python lê um arquivo Excel especificado.
      * Os dados dos alunos são extraídos e manipulados para gerar nomes de usuário e separar o primeiro nome do sobrenome.
      * O resultado é salvo em um arquivo CSV formatado, pronto para ser usado pelo script de criação de usuários.

2.  **Criação de Usuários (PowerShell):**

      * O script PowerShell `InputUSERs.ps1` lê o arquivo CSV gerado.
      * Para cada linha no CSV, ele cria um novo usuário no Active Directory com uma senha padrão.
      * Os novos usuários são automaticamente adicionados a um grupo de segurança e a uma Unidade Organizacional (UO) pré-definida. 

-----

## **Como Utilizar**

Siga os passos abaixo para configurar e executar a automação.

### **Passo 1: Configurar e Executar os Scripts Python**

Antes de criar os usuários, é necessário gerar o arquivo CSV com os dados dos alunos.

1.  **Configure o `config.py`:**

      * `CAMINHO_EXEL`: Defina o caminho completo para o seu arquivo Excel que contém a lista de alunos.
      * `NOME_COLUNA_ALVO`: Especifique o nome da coluna que contém os nomes completos dos alunos.
      * `PASTA_SAIDA_CSV`: Indique a pasta onde o arquivo CSV resultante (`Extracao_Alunos.csv`) será salvo.

2.  **Execute o script Python principal:**

      * Rode o script responsável por orquestrar a extração e manipulação dos dados. Isso irá gerar o arquivo `Extracao_Alunos.csv`.

### **Passo 2: Configurar e Executar o Script PowerShell**

Com o arquivo CSV em mãos, o próximo passo é configurar e executar o script que criará os usuários no AD.

1.  **Mova o arquivo CSV:**

      * Copie o arquivo `Extracao_Alunos.csv` gerado para o local que será lido pelo servidor. O caminho padrão no script é `\\SRVAD\Servidor\Doc Compartilhados\20. Software\T.I\UsersInput\ListaAlunos.csv`.

2.  **Edite o `InputUSERs.ps1`:**

      *** `$caminhoCSV` **: Atualize esta variável com o caminho completo onde o arquivo CSV foi colocado. 
      ** `$dominioUPN` **: Insira o domínio do seu servidor (ex: "seudominio.local"). 
      * **`$grupoDestino`**: Defina o nome do grupo de segurança do Active Directory ao qual os novos usuários serão adicionados.Recomenda-se que os usuários sejam do mesmo tipo. 
      
      ** `$caminhoOU` **: Forneça o *Distinguished Name* da Unidade Organizacional (UO) onde os usuários serão criados. 
          * *Exemplo: "OU=Alunos,OU=Direito,OU=Dourados,DC=unifron,DC=local"*

3.  **Execute o Script:**

      * Abra um console PowerShell no seu servidor Windows e navegue até a pasta onde o script `InputUSERs.ps1` está localizado.
      * Execute o comando:
        ```powershell
        ./InputUsers.ps1
        ```

### **Atenção**

  * **Cabeçalho do CSV:** Não altere a primeira linha do arquivo CSV gerado (`PrimeiroNome,Sobrenome,Login`). [cite\_start]Ela é usada pelo script PowerShell para identificar os dados corretamente. [cite: 6]
  * **Permissões:** Certifique-se de que você está executando o script PowerShell com uma conta que tenha as permissões necessárias para criar usuários no Active Directory.
  * **Modelo:** Para funcionamento pleno dos codigos, recomenda-se manter o modelo de planilha, a mesma segue junto aos arquivos com os nomes censurados para privaciade.
  * **Manutenção:** Para que o codigo funcione, será nescessário atulizar os PATHS
