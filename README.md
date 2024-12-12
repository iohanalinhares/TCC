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
O banco de dados utilizado foi o **SQLite**, uma solução leve e eficiente que se integra facilmente à plataforma Godot.  Sua estrutura relacional, com tabelas, linhas e colunas, permite organizar os dados de forma intuitiva e flexível. O SQLite foi escolhido pela sua simplicidade de implementação e por fornecer uma conexão direta e rápida com o jogo, o que é essencial para garantir o bom desempenho do projeto sem comprometer a qualidade das funcionalidades de armazenamento de dados.
### Sistema de Dicas Inteligente
Para implementar o sistema de dicas, foi utilizado o modelo multimodal **1.5 Flash** da **Gemini API do Google**, uma solução de inteligência artificial avançada que permite integrar modelos de linguagem ao jogo. Essa tecnologia possibilita a geração de dicas personalizadas, ajudando a solucionar desafios de maneira contextual e interativa. A integração com a API foi realizada por meio de requisições HTTP no Godot, garantindo que o sistema de dicas responda de forma eficiente.

# Requisitos do projeto
### Requisitos funcionais
RF01 – O sistema deve permitir que o usuário insira seu nome de usuário e senha para autenticar e acessar a plataforma.

RF02 – O sistema deve permitir a escolha do nome de usuário para ser utilizado no jogo.

RF03 – O sistema deve possuir um esquema de níveis que o usuário pode atingir enquanto joga.

RF04 – O sistema deve exibir a pontuação do jogador ao final de cada fase concluída.

RF05 – O sistema deve implementar três tipos de ajuda (dica, eliminar alternativas, resposta da IA).

RF06 – O usuário pode comprar ajudas extras para os níveis do jogo.

RF07 – O sistema deve permitir a modificação de configurações do aplicativo, como idioma, música e sons.

RF08 – O sistema deve permitir a utilização das dicas/ajudas durante o jogo.

RF09 – O sistema deve oferecer desafios e explicações sobre o assunto em cada nível.

### Requisitos não funcionais
RNF01 – O sistema executa uma música ambiente durante a execução do jogo.

RNF02 – O sistema executa sons conforme o usuário clica nos botões do jogo.

RNF03 – O sistema possui animações para mostrar as estrelas e pontuações do usuário.

RFN04 – O sistema deve ter uma interface de usuário amigável e intuitiva.

RFN05 – O sistema deve apresentar um bom desempenho e baixa latência.

RFN06 – O sistema deve ter suporte bilíngue (português e inglês).

# Metodologia de organização de tarefas
A metodologia de gerenciamento de tarefas adotada desde o início do projeto é o **Kanban**, uma abordagem visual e flexível que facilita o acompanhamento do progresso das atividades. Essa estrutura permite uma visualização clara do fluxo de trabalho, identificando gargalos e ajustando o ritmo de desenvolvimento conforme necessário. Com essa metodologia, o processo se torna mais ágil, promovendo entregas frequentes e contínuas, além de proporcionar uma gestão eficiente das demandas e recursos ao longo do projeto.

# Organização de repositório
**Addons:** Armazenamento de plugins e extensões criados e disponibilizados pela comunidade para utilização nos projetos Godot.
**Assets:** Local de armazenamento dos recursos visuais e gráficos do jogo como imagens, ícones e TileSets.
**Database:** Diretório de armazenamento do banco de dados SQLite do jogo.
**Levels:** Pasta para armazenamento dos arquivos que representam os diferentes níveis e telas do jogo.
**Scripts:** Diretório para armazenar os códigos que controlam o comportamento e as regras do jogo.
**Translation:** Pasta que armazena o arquivo de tradução do jogo em diferentes idiomas.

# TileSets e ícones
Para compor o cenário do jogo e o personagem principal, utilizei TileSets prontos, disponíveis na internet, otimizando o tempo de desenvolvimento e garantindo uma estética visual consistente. Já os ícones das telas, como os de dicas e visualização da pontuação, foram criados manualmente no Figma, com foco em melhorar a experiência do usuário, garantindo que cada elemento visual transmita clareza à sua funcionalidade.

Segue abaixo uma representação dos ícones desenvolvidos e dos TileSets utilizados:

![TileSets e ícones](/assets/images/README/TileSets.png)
*As duas primeiras colunas mostram os ícones personalizados criados no Figma, enquanto a última coluna exibe os TileSets encontrados na internet e usados no jogo.*


# Diagramas

### Diagrama de Caso de Uso: Fluxo Completo
![Diagrama de Arquitetura](/assets/images/README/Diagrama%20Caso%20de%20Uso%20-%20Fluxo%20Completo.png)
*Diagrama de caso de uso simplificado para demonstração das ações do usuário e função da Gemini AI no jogo*

### Diagrama de Arquitetura
![Diagrama de Arquitetura](/assets/images/README/Diagrama%20de%20Arquitetura.png)

# Instalação e execução do projeto
Para instalar e configurar o jogo localmente, siga este passo a passo detalhado. As instruções a seguir guiarão você por todo o processo, desde a instalação da engine até a execução do jogo.

**Pré-requisito:** Instale o Git em seu sistema para clonar o repositório do projeto.

**Guia de instalação:**

1. **Obtenha a Godot Engine:** Faça o download da versão mais recente da Godot Engine para Windows através do link https://godotengine.org/download/windows/. Siga as instruções de instalação padrão.
2. **Clone o Repositório:**
    * Abra um terminal ou prompt de comando.
    * Navegue até o diretório onde deseja salvar o projeto.
    * Execute o seguinte comando para clonar o repositório:
    `git clone https://github.com/iohanalinhares/TCC.git`
3. **Abra o Projeto na Godot:**
    * Inicie a Godot Engine.
    * Vá em "Projects" -> "Import".
    * Localize a pasta onde você clonou o projeto e o selecione
4. **Aguarde o Carregamento:** Devido ao tamanho e complexidade do projeto, pode ser necessário aguardar o tempo de carregamento. Aguarde até que todos os recursos sejam carregados.
5. **Execute o Projeto:**
    * Atalho de teclado: Pressione F5 para iniciar o projeto em modo de execução.
    * Interface gráfica: Clique no botão "Run Project" localizado no canto superior direito da janela da Godot.

**Observação:** Caso você encontre algum problema durante a instalação ou execução, verifique se todas as dependências necessárias estão instaladas e se você possui as permissões corretas para acessar os arquivos do projeto.

# Próximos passos
- Implementação de outros idiomas para tradução, tornando o conteúdo acessível a jogadores de diferentes nacionalidades e melhorar a experiência do usuário.
- Implementação de outras linguagens de programação como forma de ensino com o objetivo de ampliar o alcance educacional do projeto.
- Implementação de próximos níveis com o intúito de manter o aprendizado progressivo e engajar os jogadores, incentivando a continuidade nos estudos.
- Disponibilização do jogo na internet, visando facilitar o acesso ao jogo, aumentar sua visibilidade e alcançar um público maior.