#!/bin/bash

# Defina o endereço do servidor NFS e o caminho do diretório onde deseja enviar os arquivos de resultado
NFS_SERVER="10.0.2.15"
NFS_DIR="/nfs/edilson"

# Defina o nome do serviço
SERVICE_NAME="Apache"

# Obtenha o status do serviço Apache
SERVICE_STATUS=$(systemctl is-active apache2)

# Obtenha a data e a hora atual
CURRENT_DATE=$(date "+%Y-%m-%d_%H-%M-%S")

# Verifique se o serviço está online ou offline e defina a mensagem correspondente
if [ "$SERVICE_STATUS" = "active" ]; then
    STATUS_MESSAGE="online"
    RESULT_FILE="$NFS_DIR/$SERVICE_NAME\_online_$CURRENT_DATE.txt"
else
    STATUS_MESSAGE="offline"
    RESULT_FILE="$NFS_DIR/$SERVICE_NAME\_offline_$CURRENT_DATE.txt"
fi

# Crie o conteúdo do arquivo de resultado
RESULT="Data e hora: $CURRENT_DATE\nServiço: $SERVICE_NAME\nStatus: $SERVICE_STATUS\nMensagem: O serviço $SERVICE_NAME está $STATUS_MESSAGE."

# Envie o resultado para o arquivo correspondente no diretório do NFS
echo -e "$RESULT" > "$RESULT_FILE"

# Exiba uma mensagem indicando que o resultado foi enviado com sucesso
echo "Resultado da validação do serviço $SERVICE_NAME enviado para $RESULT_FILE"
