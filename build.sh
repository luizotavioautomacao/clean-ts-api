#!/bin/bash

# Atualiza o sistema
sudo apt update

# Instala o Node.js e npm se não estiverem instalados
if ! command -v node &> /dev/null || ! command -v npm &> /dev/null
then
    echo "Node.js e/ou npm não encontrados. Instalando Node.js e npm..."
    
    # Instala dependências
    sudo apt install -y curl

    # Adiciona o repositório NodeSource
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    
    # Instala Node.js e npm
    sudo apt install -y nodejs
    
    # Verifica se a instalação foi bem-sucedida
    if command -v node &> /dev/null && command -v npm &> /dev/null
    then
        echo "Node.js e npm instalados com sucesso."
    else
        echo "Falha ao instalar Node.js e npm."
    fi
else
    echo "Node.js e npm já estão instalados."
fi

# Adicione outras instalações ou configurações conforme necessário
# Por exemplo, instalar o Git:
# sudo apt install -y git

echo "Script de configuração concluído."
