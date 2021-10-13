# LARC2021-Docker-UnBeatables

vcs vão buildar entrando na pasta que vcs baixarem isso e rodando 
`sudo docker build -t alvimpaulo/larc-2021-jogador .`
Eu recomendo criar uma conta no dockerhub e tagar com o seu login, para poder fazer push para lá tb. 

Um detalhe é que vcs vao precisar copiar a pasta `webots` e a pasta `UnBeatables_Humanoid_Competition_Code` para dentro da raiz desse repositório.
Essa pasta webots é a pasta que normalmente vcs rodam a motion.wbt ou walking.wbt. Enfim, a cena que o webots roda que é só o darwin em um mundo aleatório.

Pode ser que vcs precisem deletar algumas coisas da pasta `webots` de vcs. 
- O /lib/controller/libCppController.so muito provavelmente
- As builds que são feitas com os makes normalmente.
  - src/controller/cpp
  - webots/projects/robots/robotis/darwin-op/libraries/python38/_managers.so
  
Se vcs forem tirar o webots, provavelmente vao precisar mudar a imagem no inicio do dockerfile de `FROM cyberbotics/webots:R2021b-ubuntu18.04`  para alguma coisa tipo `FROM ubuntu:18.04` ou `nvidia/cudagl:10.0-devel-ubuntu18.04`  ou entao procurar essas imagens no ubuntu 20.
Só que aí vcs vão bater em problemas de arquivos e bibliotecas faltando, possívelmente. Se for o caso, tem que escrever `RUN apt update && apt-get install -y <PACOTES>`. 
O update é importante pq as vezes o build n acha os pacotes sem isso.

Dps de buildar vc vai tagear com o nome da competição, usando o comando `sudo docker tag alvimpaulo/larc-2021-jogador 834282931378.dkr.ecr.us-east-1.amazonaws.com/cbr2021-unbeatables`. 
Só presta atenção na tag que vc usou para buildar o container do jogador na sua maquina. A minha é `alvimpaulo/larc-2021-jogador` mas a de vcs pode ser diferente.

Depois de tagar a img, vc vai precisar fazer o push dela para o servidor da competição:
- Para dar push para um servidor da amazon vai precisar instalar o cli deles, com `pip install awscli --upgrade --user´. 
- Depois vai precisar rodar `aws configure` com as credenciais que o vinicius mandou no email. Foi um arquivo .csv.
- dps do `aws configure`, vai precisar rodar `aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin "$(aws sts get-caller-identity --query 'Account' --output text).dkr.ecr.us-east-1.amazonaws.com"` para autenticar com o servidor deles. 
  Isso expira e a cada 12 hrs vai precisar rodar esse comando de novo.
- Aí, uma vez autenticado é só dar o push certinho com `docker push 834282931378.dkr.ecr.us-east-1.amazonaws.com/cbr2021-unbeatables` e partir pro abraço. 
  Pode ser que vc precise colocar seu usuário no grupo do docker para dar esse push sem sudo. Isso é explicado aqui https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo.

