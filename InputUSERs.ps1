<#
.SYNOPSIS
    Script para criar usuários no Active Directory em massa a partir de um arquivo CSV.
.DESCRIPTION
    Este script le um arquivo CSV, cria cada usuario com os dados fornecidos,
    define uma senha padrão e o adiciona a um grupo específico dentro de uma OU definida.
.AUTHOR
    Jose Gabriel
.DATE
    01/08/2025
#>


# Edite as variaveis nesta seçao de acordo com seu ambiente.

# Caminho completo para o arquivo CSV.
$caminhoCSV = "CAMINHO_ARQUIVO_CSV"

# Dominio para o UserPrincipalName (ex: usuario@seudominio.local).
$dominioUPN = "SEU_DOMINIO"

# Senha padrao para todos os novos usuários.
$senhaPadrao = "000000"

# Nome do grupo ao qual os novos usuários serao adicionados.
$grupoDestino = "NOME_GRUPO"


# Substitua pelo Distinguished Name correto do seu ambiente
$caminhoOU = "Distinguished Name"  # <<<<< NOVA LINHA




$senhaSegura = ConvertTo-SecureString $senhaPadrao -AsPlainText -Force

if (-not (Test-Path $caminhoCSV)) {
    Write-Host "ERRO: O arquivo CSV nao foi encontrado em '$caminhoCSV'." -ForegroundColor Red
    exit
}

$usuarios = Import-Csv -Path $caminhoCSV


foreach ($usuario in $usuarios) {
    # ... (aqui continua a definição das variáveis $primeiroNome, $sobrenome, etc.) ...
    $primeiroNome    = $usuario.PrimeiroNome.Trim()
    $sobrenome       = $usuario.Sobrenome.Trim()
    $samAccountName  = $usuario.Login.Trim()
    $nomeCompleto    = "$primeiroNome $sobrenome"
    $userPrincipalName = "$samAccountName@$dominioUPN"

    
    # Este bloco vai imprimir os dados que serão usados para o usuário atual.
    #Write-Host "------------------------------------------------------" -ForegroundColor Cyan
    #Write-Host "DEBUG: Tentando criar usuário com os seguintes dados:" -ForegroundColor Cyan
    #Write-Host "  - Name:               '$nomeCompleto'"
    #Write-Host "  - GivenName:          '$primeiroNome'"
    #Write-Host "  - Surname:            '$sobrenome'"
   # Write-Host "  - SamAccountName:       '$samAccountName'"
   # Write-Host "  - UserPrincipalName:    '$userPrincipalName'"
   # Write-Host "  - Path (Caminho da OU): '$caminhoOU'"  # VERIFIQUE ESTE VALOR COM ATENÇÃO!
   # Write-Host "------------------------------------------------------" -ForegroundColor Cyan
    

    try {
        
        $userParams = @{
            Name                  = $nomeCompleto
            GivenName             = $primeiroNome
            Surname               = $sobrenome
            SamAccountName        = $samAccountName
            UserPrincipalName     = $userPrincipalName
            AccountPassword       = $senhaSegura
            Path                  = $caminhoOU
            Enable                = $true
            ChangePasswordAtLogon = $true
            ErrorAction           = 'Stop'
        }
        
        $novoUsuario = New-ADUser @userParams -PassThru
        Add-ADGroupMember -Members $novoUsuario -Identity $grupoDestino -ErrorAction Stop
        
        Write-Host "SUCESSO: Usuario '$nomeCompleto' criado em '$caminhoOU' e adicionado ao grupo '$grupoDestino'." -ForegroundColor Green
    }
    catch {
        Write-Host "FALHA: Nao foi possível criar o usuario '$nomeCompleto'. Erro: $($_.Exception.Message)" -ForegroundColor Red
    }
}

