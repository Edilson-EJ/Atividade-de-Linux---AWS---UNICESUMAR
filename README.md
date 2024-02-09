
# Atividade de Linux - AWS - UNICESUMAR

# Descrição da atividade

# Requisitos AWS

    - Gerar uma chave pública para acesso ao ambiente;

    -  Criar 1 instância EC2 com o sistema operacional Amazon Linux 2 (Família
            t3.small, 16 GB SSD);
    -  Gerar 1 elastic IP e anexar à instância EC2;

    -  Liberar as portas de comunicação para acesso público: (22/TCP, 111/TCP e
        UDP, 2049/TCP/UDP, 80/TCP, 443/TCP).

# Requisitos LINUX

    - Configurar o NFS entregue;

    - Criar um diretorio dentro do filesystem do NFS com seu nome;

    - Subir um apache no servidor - o apache deve estar online e rodando;

    - Criar um script que valide se o serviço esta online e envie o resultado da
        validação para o seu diretorio no nfs;

    - O script deve conter - Data HORA + nome do serviço + Status + mensagem
        personalizada de ONLINE ou offline;

    - O script deve gerar 2 arquivos de saida: 1 para o serviço online e 1 para o
        serviço OFFLINE;

    -  Preparar a execução automatizada do script a cada 5 minutos.

# AWS
- Gerar uma chave pública para acesso ao ambiente:

    1: No painel de controle, vá para o serviço "EC2" clicando em "Services" e depois   em "EC2" ou pesquisando diretamente por "EC2".

    2: No painel de navegação do lado esquerdo, clique em "Key Pairs" sob a seção "Network & Security".

    3: Clique no botão "Create Key Pair".

    4: Escolha um nome para a chave (por exemplo, "my-key-pair").

    5: Selecione o formato do arquivo de chave. Recomenda-se escolher o formato "pem".

    6: Clique em "Create Key Pair".

    7: O arquivo de chave privada (com extensão .pem) será baixado automaticamente para o seu computador. Guarde este arquivo em um local seguro, pois será necessário para acessar suas instâncias EC2.

    8: A chave pública correspondente será automaticamente importada para a AWS e estará associada à sua conta.

- Criar 1 instância EC2 com o sistema operacional Amazon Linux 2 (Família
t3.small, 16 GB SSD):

    1: No painel de controle, vá para o serviço "EC2" clicando em "Services" e depois em "EC2" ou pesquisando diretamente por "EC2".

    2: No painel de navegação do lado esquerdo, clique em "Instances" e depois em "Launch Instances".

    3: Na página "Choose an Amazon Machine Image (AMI)", selecione "Amazon Linux 2 AMI". Você pode filtrar as opções digitando "Amazon Linux 2" na barra de pesquisa.

    4: Na página "Choose an Instance Type", selecione a família "General purpose" e o tipo "t3.small". Certifique-se de que a opção "Free tier eligible" esteja marcada para garantir que você não será cobrado pelo uso do serviço, desde que esteja dentro dos limites do nível gratuito.

    5: Clique em "Next: Configure Instance Details" para continuar.

    6: Na página "Configure Instance Details", você pode configurar as opções de rede, armazenamento, configurações avançadas, etc. Para as configurações padrão, você pode prosseguir sem alterações. Certifique-se de que o "Network" e a "Subnet" estejam configurados de acordo com sua rede VPC e subnet desejadas.

    7: Clique em "Next: Add Storage" para continuar.

    8: Na página "Add Storage", você pode adicionar e configurar o armazenamento da instância. Por padrão, uma instância t3.small vem com armazenamento EBS de 8 GB. aumente o tamanho para 16 GB.

    9: Clique em "Next: Add Tags" para continuar.


    10 :  Key          Value                  Resource types
            Name          PB UNICESUMAR             Instances
                                                    Volumes
          Key          Value                  Resource types
            CostCenter     C092000024               Instances
                                                    Volumes
          Key          Value                  Resource types
            Project          PB UNICESUMAR           Instances
                                                     Volumes
    
    11: Clique em "Next: Configure Security Group" para continuar. Na página "Configure Security Group", você pode configurar as regras de firewall para controlar o tráfego de rede para sua instância. Por padrão, uma regra para SSH (porta 22) é adicionada para permitir a conexão remota à instância. Se desejar, você pode adicionar outras regras de entrada conforme necessário para suas aplicações.

    12: Clique em "Launch" para iniciar a instância.

Gerar 1 elastic IP e anexar à instância EC2:

    1: No painel de serviços, clique em "EC2" para abrir o console do Amazon EC2.

    2: No painel de navegação à esquerda, clique em "Elastic IPs" abaixo da seção "Network & Security".

    3: Na página Elastic IPs, clique em "Allocate new address".

    4: Na janela que aparece, selecione "Amazon's pool of IPv4 addresses" se você deseja um endereço IP público da pool da AWS, ou selecione "Bring your own IP address" se você tiver seu próprio bloco de endereços IP (este último requer que você já tenha um bloco IP alocado).

    5: Clique em "Allocate".

    6: Após a alocação bem-sucedida, você verá uma nova entrada na lista de IPs elásticos com o endereço IP recém-alocado.

    7: Selecione o endereço IP recém-alocado na lista clicando na caixa de seleção ao lado dele.

    8: No menu suspenso "Actions" acima da lista, selecione "Associate address".

    9: No formulário "Associate Address", selecione a instância EC2 à qual você deseja associar o endereço IP.

    10: Selecione a instância desejada na lista de instâncias disponíveis.

    11: O campo "Private IP" deve ser preenchido automaticamente com o endereço IP privado da instância selecionada. Clique em "Associate".

Liberar as portas de comunicação para acesso público: (22/TCP, 111/TCP e
UDP, 2049/TCP/UDP, 80/TCP, 443/TCP):

    1: No painel de serviços, clique em "EC2" para abrir o console do Amazon EC2.

    2: No painel de navegação à esquerda, clique em "Security Groups" abaixo da seção "Network & Security".

    3: Selecione o grupo de segurança associado à sua instância EC2 na lista.

    4: Na guia "Inbound rules" (regras de entrada), clique no botão "Edit inbound rules".

    5: Clique no botão "Add rule" para adicionar novas regras de entrada.

    6: Adicione as seguintes regras para as portas específicas mencionadas:
    
    6.1: SSH (22/TCP): Adicione uma regra com Type: SSH, Protocol: TCP, Port Range: 22 e Source: 0.0.0.0/0 para permitir acesso SSH de qualquer lugar.

    6.2: RPCBIND (111/TCP e UDP): Adicione uma regra com Type: Custom TCP Rule, Protocol: TCP, Port Range: 111 e Source: 0.0.0.0/0. Repita o mesmo para o protocolo UDP.

    6.3: NFS (2049/TCP e UDP): Adicione uma regra com Type: Custom TCP Rule, Protocol: TCP, Port Range: 2049 e Source: 0.0.0.0/0. Repita o mesmo para o protocolo UDP.

    6.4: HTTP (80/TCP): Adicione uma regra com Type: HTTP, Protocol: TCP, Port Range: 80 e Source: 0.0.0.0/0 para permitir acesso HTTP de qualquer lugar.

    6.5: HTTPS (443/TCP): Adicione uma regra com Type: HTTPS, Protocol: TCP, Port Range: 443 e Source: 0.0.0.0/0 para permitir acesso HTTPS de qualquer lugar.

    7: Após adicionar todas as regras necessárias, clique no botão "Save rules" para aplicar as alterações.

    8: launch_wizard-2

    8.1: 7 entradas de permissão

# Linux

- Configurar o NFS entregue:

    1: Atualizar o Sistema: sudo apt update depois execute sudo apt upgrade

    2: Instalar o Servidor NFS: sudo apt install nfs-kernel-server

    3: Configurar os Compartilhamentos NFS: /var/nfs *(rw,sync,no_root_squash)
    
    4: Aplicar as Configurações do NFS:
        sudo exportfs -a

    5: Iniciar o Serviço NFS: sudo systemctl restart nfs-kernel-server

    6:  Verificar o Status do Serviço NFS,  verificar se o serviço NFS está em execução sem erros usando o seguinte comando: sudo systemctl status nfs-kernel-server


- Para acessar a instância que está exportando o diretório via NFS utilizando SSH, siga estas etapas:

    1: Abra um terminal ou prompt de comando no seu sistema local.

    2: Use o comando ssh seguido do endereço IP público da instância EC2 e o nome do usuário SSH. Por exemplo:

    2.1: ssh -i caminho/para/sua/chave-privada.pem usuario@endereco_ip_da_instancia

    2.2: Substitua caminho/para/sua/chave-privada.pem pelo caminho para o arquivo de chave privada que corresponde à chave que você usou ao lançar a instância EC2. Substitua usuario pelo nome do usuário SSH que você está usando para se conectar à instância e endereco_ip_da_instancia pelo endereço IP público da instância EC2.

    3:  Pressione Enter. O SSH tentará se conectar à instância usando a chave privada especificada.

    4: Se for a primeira vez que você está se conectando a essa instância, o SSH pode pedir para confirmar a autenticidade da instância. Digite yes para confirmar.

    5: Se a autenticação for bem-sucedida, você será conectado à instância e verá um prompt de comando da instância. Agora você está conectado à instância via SSH e pode executar comandos nela.

- Criar um diretorio dentro do filesystem do NFS com seu nome:

    1: Acesse a instância que está exportando o diretório via NFS. Isso geralmente é feito usando SSH.

    2: Use o comando mkdir para criar o diretório dentro do diretório exportado. Por exemplo, se o diretório exportado for /var/nfs, e seu nome for "usuario1", você pode criar um diretório com o seu nome usando o seguinte comando:

    2.1 : sudo mkdir /nfs/edilson

    3: Verifique se o diretório foi criado com sucesso:

    3.1: ls -l /nfs/edilson

    4: Configure as permissões do diretório:

    4.1: sudo chmod -R 777 /nfs/edilson

    5: Configure o arquivo /etc/exports:

    5.1: como acessa o  /etc/exports:

    5.1.1: sudo nano /etc/exports

    5.2: Edite o arquivo /etc/exports para especificar quais diretórios serão compartilhados e quais hosts podem acessá-los. Adicione uma linha para cada diretório compartilhado. Por exemplo, para compartilhar /nfs/share com acesso de leitura e gravação para todos os hosts na rede, você pode adicionar a seguinte linha:

    5.3: /nfs/edilson *(rw,sync,no_root_squash)

    5.4: Para salvar e sair do editor de texto, dependendo do editor que você está usando, você precisa seguir diferentes passos:

    5.4.1: Pressione Ctrl + O para escrever as alterações no arquivo.
            Pressione Enter para confirmar o nome do arquivo.
            Pressione Ctrl + X para sair do editor.
    
    6: Depois de adicionar essa linha (ou linhas) ao arquivo /etc/exports, salve o arquivo e reinicie o serviço NFS para aplicar as alterações. Você pode reiniciar o serviço com o seguinte comando:

    6.1: sudo systemctl restart nfs-kernel-server


- Subir um apache no servidor - o apache deve estar online e rodando:

    1: Conectar-se à instância EC2 via SSH:

    2: Atualizar o sistema:

    2.1: sudo apt update && sudo apt upgrade

    3: Instalar o Apache:

    3.1: sudo apt install apache2 

    4: Iniciar o Serviço Apache:

    4.1: sudo systemctl start apache2

    5: Verificar o Status do Apache:

    5.1: sudo systemctl status apache2  

    6: Configurar para iniciar na inicialização:

    6.1: sudo systemctl enable apache2 

- Criar um script que valide se o serviço esta online e envie o resultado da
validação para o seu diretorio no nfs:

    #!/bin/bash

    1: Defina o endereço do servidor NFS e o caminho do diretório onde deseja enviar o arquivo de resultado
    NFS_SERVER="endereco_do_servidor_nfs"
    NFS_DIR="/caminho/para/seu/diretorio_nfs"

    2: Verifica o status do serviço Apache
    APACHE_STATUS=$(systemctl is-active apache2)

    3: Define o nome do arquivo de resultado
    RESULT_FILE="resultado_apache.txt"

    4: Define o conteúdo do arquivo de resultado com base no status do Apache
    if [ "$APACHE_STATUS" = "active" ]; then
        RESULT="O serviço Apache está online."
    else
        RESULT="O serviço Apache está offline."
    fi

    5: Envie o resultado para o diretório no NFS
    echo "$RESULT" > "$NFS_DIR/$RESULT_FILE"

    6: Exiba uma mensagem indicando que o resultado foi enviado com sucesso
    echo "Resultado da validação do Apache enviado para $NFS_DIR/$RESULT_FILE"

- NFS_SERVER="endereco_do_servidor_nfs":

    1: Para encontrar o endereço do servidor NFS, você pode usar o comando ifconfig ou ip addr no terminal do servidor Linux onde o NFS está configurado. Isso mostrará os detalhes de rede, incluindo o endereço IP do servidor.

    2: A entrada "inet 10.0.2.15/24" indica que o endereço IP do servidor NFS é 10.0.2.15 e está em uma rede com uma máscara de sub-rede /24 (ou seja, uma máscara de sub-rede de 255.255.255.0).

- NFS_DIR="/caminho/para/seu/diretorio_nfs":

    1: Substituir pelo diretório onde está o arquivo.

    1.1: /nfs/edilson

- O script deve conter - Data HORA + nome do serviço + Status + mensagem
personalizada de ONLINE ou offline:

    Modificando o script anterior para incluir data e hora.

    1: Defina o endereço do servidor NFS e o caminho do diretório onde deseja enviar o arquivo de resultado
    NFS_SERVER="endereco_do_servidor_nfs"
    NFS_DIR="/caminho/para/seu/diretorio_nfs"

    2: Defina o nome do serviço e obtenha seu status
        SERVICE_NAME="Apache"
        SERVICE_STATUS=$(systemctl is-active apache2)

    3:  Obtenha a data e a hora atual
        CURRENT_DATE=$(date "+%Y-%m-%d %H:%M:%S")

    4: Verifique se o serviço está online ou offline e defina a mensagem correspondente
        if [ "$SERVICE_STATUS" = "active" ]; then
            STATUS_MESSAGE="online"
        else
            STATUS_MESSAGE="offline"
        fi

    5:  Define o conteúdo do arquivo de resultado
        RESULT="Data e hora: $CURRENT_DATE\nServiço: $SERVICE_NAME\nStatus: $SERVICE_STATUS\nMensagem: O serviço $SERVICE_NAME está $STATUS_MESSAGE."

    6:  Define o nome do arquivo de resultado
        RESULT_FILE="resultado_servico.txt"

    7:  Envie o resultado para o diretório no NFS
        echo -e "$RESULT" > "$NFS_DIR/$RESULT_FILE"

    8: Exiba uma mensagem indicando que o resultado foi enviado com sucesso
    echo "Resultado da validação do serviço $SERVICE_NAME enviado para $NFS_DIR/$RESULT_FILE"

- O script deve gerar 2 arquivos de saida: 1 para o serviço online e 1 para o
serviço OFFLINE:

    Para gerar dois arquivos de saída separados, um para o serviço online e outro para o serviço offline, você pode modificar o script para verificar o status do serviço Apache e escrever o resultado em arquivos diferentes com base nesse status.

    1:  Defina o endereço do servidor NFS e o caminho do diretório onde deseja enviar os arquivos de resultado
        NFS_SERVER="endereco_do_servidor_nfs"
        NFS_DIR="/caminho/para/seu/diretorio_nfs"

    2: Defina o nome do serviço
        SERVICE_NAME="Apache"

    3: Obtenha o status do serviço Apache
        SERVICE_STATUS=$(systemctl is-active apache2)

    4:  Obtenha a data e a hora atual
        CURRENT_DATE=$(date "+%Y-%m-%d_%H-%M-%S")

    5: Verifique se o serviço está online ou offline e defina a mensagem correspondente
        if [ "$SERVICE_STATUS" = "active" ]; then
            STATUS_MESSAGE="online"
            RESULT_FILE="$NFS_DIR/$SERVICE_NAME\_online_$CURRENT_DATE.txt"
        else
            STATUS_MESSAGE="offline"
            RESULT_FILE="$NFS_DIR/$SERVICE_NAME\_offline_$CURRENT_DATE.txt"
        fi

    6: Crie o conteúdo do arquivo de resultado
    RESULT="Data e hora: $CURRENT_DATE\nServiço: $SERVICE_NAME\nStatus: $SERVICE_STATUS\nMensagem: O serviço $SERVICE_NAME está $STATUS_MESSAGE."

    7: Envie o resultado para o arquivo correspondente no diretório do NFS
        echo -e "$RESULT" > "$RESULT_FILE"

    8: Exiba uma mensagem indicando que o resultado foi enviado com sucesso
        echo "Resultado da validação do serviço $SERVICE_NAME enviado para $RESULT_FILE"

- Preparar a execução automatizada do script a cada 5 minutos.

    1: Abra o crontab para edição digitando o seguinte comando no terminal:
        crontab -e

    2: Adicione a seguinte linha ao final do arquivo crontab para configurar a execução do script a cada 5 minutos.
        */5 * * * * /caminho/para/seu/script.sh

    2.1: Substitua /caminho/para/seu/script.sh pelo caminho completo para o script que você deseja executar. Por exemplo, se você salvou o script em /home/usuario/check_apache_status.sh, a linha no crontab seria.
        */5 * * * * /home/usuario/check_apache_status.sh

    3: Salve e feche o arquivo do crontab. No nano, você pode fazer isso pressionando Ctrl + O para salvar e Ctrl + X para sair.




