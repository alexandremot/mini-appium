FROM debian:buster-slim

# Atualizar e instalar dependências
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget unzip curl gnupg

# Configurar o PATH
ENV PATH="/usr/local/bin:$PATH"

# Definir NVM_DIR e HOME
ENV NVM_DIR="/root/.nvm"
ENV HOME="/root"

# Criar diretório para NVM
RUN mkdir -p /usr/local/nvm

RUN curl --silent -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install --lts \
    && nvm alias default node \
    && nvm use default

    RUN . $NVM_DIR/nvm.sh \
    && npm install -g appium \
    && appium --version > /tmp/appium_version.txt

    RUN echo "\n(appium version :" $(cat /tmp/appium_version.txt) ")\n"
    