# Objetivo do projeto
Este projeto visa criar um jogo educacional WEB em formato RPG para ensinar programação de forma divertida e interativa. Destinado a uma ampla faixa etária e níveis de conhecimento, o jogo combina perguntas, explicações do assunto, um sistema de dicas e pontuação para incentivar o aprendizado. Animações, sons e música tornam a experiência interativa.

# Tecnologias utilizadas
### Prototipação
Para a criação e prototipação das telas do jogo, foi utilizado o software **Figma**, uma ferramenta amplamente reconhecida por sua eficiência na elaboração de interfaces visuais. O Figma permitiu a definição da paletas de cores e estilos, garantindo a coerência visual do jogo desde as fases iniciais do desenvolvimento.
### Gerenciamento de atividades
O gerenciamento das atividades e tarefas do projeto foi realizado por meio da plataforma **Trello**. As tarefas são organizadas em quadros, sendo classificadas de acordo com o nível de prioridade e estágio de desenvolvimento.
### Desenvolvimento do jogo
A plataforma escolhida para o desenvolvimento do jogo é a **Godot**, uma engine de código aberto que oferece uma grande flexibilidade para a criação tanto da parte gráfica quanto dos requisitos funcionais e integrações do jogo.
### Banco de Dados
O banco de dados utilizado foi o **SQLite**, uma solução leve e eficiente que se integra facilmente à plataforma Godot. O SQLite foi escolhido pela sua simplicidade de implementação e por fornecer uma conexão direta e rápida com o jogo, o que é essencial para garantir o bom desempenho do projeto sem comprometer a qualidade das funcionalidades de armazenamento de dados.
### Sistema de Dicas Inteligente
Para implementar o sistema de dicas, foi utilizada a **Gemini API do Google**, uma solução de inteligência artificial avançada que permite integrar modelos de linguagem ao jogo. Essa tecnologia possibilita a geração de dicas personalizadas, ajudando a solucionar desafios de maneira contextual e interativa. A integração com a API foi realizada por meio de requisições HTTP no Godot, garantindo que o sistema de dicas responda de forma eficiente.

# Requisitos do projeto
### Requisitos funcionais
RF01 – O sistema deve permitir que o usuário insira seu nome de usuário e senha para autenticar e acessar a plataforma.

RF02 – O sistema deve permitir que o usuário escolha qual a linguagem deseja aprender.

RF03 – O sistema deve permitir a escolha e alteração do nome de usuário para ser utilizado no jogo.

RF04 – O sistema deve possuir um esquema de níveis que o usuário pode atingir enquanto joga.

RF05 – O sistema deve exibir apenas a pontuação do jogador ao final de cada fase concluída.

RF06 – O sistema deve implementar três tipos de ajuda (dica, eliminar alternativas, resposta da IA).

RF07 – O usuário pode comprar ajudas extras para os níveis do jogo.

RF08 – O sistema deve permitir a modificação de configurações do aplicativo, como idioma, música e sons.

RF09 – O sistema deve permitir a utilização das dicas/ajudas durante o jogo.

RF10 – O sistema deve oferecer desafios e explicações sobre o assunto em cada nível. 

RF11 – O sistema deve ajustar a dificuldade das perguntas conforme o usuário progride.

RF12 – O sistema deve oferecer a possibilidade de suporte e feedback.

### Requisitos não funcionais
RNF01 – O sistema deve permitir o aprendizado de múltiplas linguagens de programação.

RNF02 – O sistema executa uma música ambiente durante a execução do jogo.

RNF03 – O sistema executa sons conforme o usuário clica nos botões do jogo.

RNF04 – O sistema possui animações para mostrar as estrelas e pontuações do usuário.

RFN05 – O sistema deve ter uma interface de usuário amigável e intuitiva.

RFN06 – O sistema deve apresentar um bom desempenho e baixa latência.

RFN07 – O sistema deve ter suporte bilíngue (português e inglês).

# Metodologia de organização de tarefas
A metodologia de gerenciamento de tarefas adotada desde o início do projeto é o **Kanban**, uma abordagem visual e flexível que facilita o acompanhamento do progresso das atividades. Essa estrutura permite uma visualização clara do fluxo de trabalho, identificando gargalos e ajustando o ritmo de desenvolvimento conforme necessário. Com essa metodologia, o processo se torna mais ágil, promovendo entregas frequentes e contínuas, além de proporcionar uma gestão eficiente das demandas e recursos ao longo do projeto.

# Diagramas

### Diagrama de Caso de Uso: Login
![Diagrama de Caso de Uso - Login](/assets/images/README/Diagrama%20Caso%20de%20Uso%20-%20Login.png)

### Diagrama de Caso de Uso: Cadastro
![Diagrama de Arquitetura](/assets/images/README/Diagrama%20Caso%20de%20Uso%20-%20Cadastro.png)

### Diagrama de Caso de Uso: Fluxo Completo
![Diagrama de Arquitetura](/assets/images/README/Diagrama%20Caso%20de%20Uso%20-%20Fluxo%20Completo.png)

### Diagrama de Arquitetura

![Diagrama de Arquitetura](/assets/images/README/Diagrama%20de%20Arquitetura.png)
