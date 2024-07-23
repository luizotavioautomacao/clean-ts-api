#!/bin/bash

# chmod +x build.sh

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
        exit 1
    fi
else
    echo "Node.js e npm já estão instalados."
fi

# Instala as dependências do Node.js
echo "Instalando dependências do Node.js..."
npm install
npm audit fix #--force

# Instala o Docker se não estiver instalado
if ! command -v docker &> /dev/null
then
    echo "Docker não encontrado. Instalando Docker..."
    
    # Instala pacotes necessários
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

    # Adiciona a chave GPG do Docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    # Adiciona o repositório Docker
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

    # Atualiza o índice de pacotes
    sudo apt update

    # Instala Docker
    sudo apt install -y docker-ce

    # Verifica se a instalação foi bem-sucedida
    if command -v docker &> /dev/null
    then
        echo "Docker instalado com sucesso."
    else
        echo "Falha ao instalar Docker."
        exit 1
    fi
else
    echo "Docker já está instalado."
fi

# Instala o Docker Compose se não estiver instalado
if ! command -v docker-compose &> /dev/null
then
    echo "Docker Compose não encontrado. Instalando Docker Compose..."

    # Baixa o Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose

    # Torna o binário executável
    sudo chmod +x /usr/local/bin/docker-compose

    # Verifica se a instalação foi bem-sucedida
    if command -v docker-compose &> /dev/null
    then
        echo "Docker Compose instalado com sucesso."
    else
        echo "Falha ao instalar Docker Compose."
        exit 1
    fi
else
    echo "Docker Compose já está instalado."
fi

# Adiciona o usuário ao grupo docker
if ! groups $USER | grep -q '\bdocker\b'; then
    echo "Adicionando o usuário $USER ao grupo docker..."
    sudo usermod -aG docker $USER

    # Solicita ao usuário que faça logout e login novamente
    echo "O usuário $USER foi adicionado ao grupo docker."
    echo "O sistema será reiniciado para que as alterações tenham efeito."
    
    # Reinicia o sistema
    echo "Script de configuração concluído. A máquina precisa ser reiniciada!"
    sudo reboot
else
    echo "O usuário $USER já está no grupo docker."
    echo "Executando o build e o docker-compose..."
    npm run up
fi

