#### PRIMEIRO DIA -----
# Aprendemos a fazer a importa??o dos dados,
# criar um filtro, mexer com alguns operadores 
# lógicos e a encontrar algumas informa??es b?sicas
# de estatística (máxima, mínimo, média, mediana e desvio padrão).

# Terminamos o encontro com um problema:
# 1. Abrir Matrículas(sav) 2012;
# 2. Selecionar as escolas PEI
# 3. Ler a frequência de matrículas por etapa escolar


#### SEGUNDO DIA  -----
library(tidyverse)
library(haven)

Mat12 <- read_sav("d:/Dropbox/mapasreorganizacao/DadosEducacionais/CensoEscolar/micro_censo_escolar_2012/2012/DADOS/MATRICULA_SUDESTE/2012Mat_SP-EEs.sav")

#### Identificando as PEIs [flag]
# Pegar a lista das escolas PEI no arquivo
# excel disponível no drive (https://docs.google.com/document/d/13ze1r-lAVsmsnpDFg6BwWPxQ37C_pPgq/edit?usp=sharing&ouid=114367707141146936253&rtpof=true&sd=true)

## flag
flag <- Mat12 %>% 
  mutate(flag_PEI = PK_COD_ENTIDADE %in% c('35003669','35003700','35028794','35028915','35029178',
                                           '35012191','35013365','35019720','35049499',
                                           '35462378','35462342','35442550','35005548',
                                           '35005551','35040548','35462330'))

Pei12 <- flag %>% # filtro
  filter(flag_PEI == 1)

table(Pei12$FK_COD_ETAPA_ENSINO) #frequência: quantas matrículas por cada etapa de ensino
table(Pei12$TP_SEXO) #frequência: quantas matrículas por sexo
table(Pei12$TP_COR_RACA) #frequência: quantas matrículas por cor-raça


#### Recodificando variáveis 
EtapaPEI <- Pei12 %>% 
  mutate(ETAPA = case_when(
    FK_COD_ETAPA_ENSINO %in% 25:29 ~ "EM",
    FK_COD_ETAPA_ENSINO %in% 45 ~ "EJA",
  )
  )

table(EtapaPEI$ETAPA)


# Exercício 1:
# Qual o percentual de pessoas negras
# matriculadas nas escolas PEIs, em 2012?





#### juntando tabelas (merge)
Turmas12 <- read_sav("Área de Trabalho/2012TurmasSP_EEs.sav")
glimpse(Turmas12)


#### Criando uma nova tabela (dataframe) com X colunas selecionadas
TurSelect <- Turmas12[, c("PK_COD_TURMA", "HR_INICIAL")]      
TurSelect2 <- Turmas12 [, c(2,4)]


#### merge [tipo um PROCV, no excel] - Para saber mais: https://rpubs.com/CristianaFreitas/311735 
MatTurma <- inner_join(Pei12, TurSelect, by = c("PK_COD_TURMA" = "PK_COD_TURMA"))

table(MatTurma$HR_INICIAL)


# Exercício 2:
# A partir da tabela "MatTurma", crie tr?s novas colunas:
# uma com os nomes das etapas escolares, 
# outra com os turnos (Manhã, Tarde e Noite) e
# mais uma com as classificações de cor-raça.





#### CROSSTABLE
attach(TurnoEtapaEtnia)
CrossEtnia <-table(ETAPA, ETNIA)  # lógica: Novo Valor <- table(coluna, linha)
CrossEtnia

CrossMat <- table(ETAPA, TURNO)
CrossMat


# Exercício 3:
# Identificar o total de matrículas, por etapa
# em cada escola PEI





#### Cálculos ou conhecendo o 'group_by'
table(TurnoEtapaEtnia$FK_COD_ETAPA_ENSINO)

TurnoEtapaEtnia %>% 
  group_by(FK_COD_ETAPA_ENSINO) %>% 
  count()


#### Total de matrículas, por escola
CalEsc <- TurnoEtapaEtnia %>% 
  group_by(PK_COD_ENTIDADE) %>% 
  count()
View(CalEsc)

## Estatísticas por escola (proporção alunos por escola)
summary(CalEsc$n)


#### Total de etapas oferecidas, por escola
CalEtapaEsc <- TurnoEtapaEtnia %>% 
  group_by(PK_COD_ENTIDADE, ETAPA) %>% 
  count()

CalEtapaEsc2 <- CalEtapaEsc %>% 
  group_by(PK_COD_ENTIDADE) %>% 
  count()
view(CalEtapaEsc2)


## Estatísticas por turma (proporção alunos por turma)
CalTurmas <- TurnoEtapaEtnia %>% 
  group_by(PK_COD_TURMA, FK_COD_ETAPA_ENSINO) %>% 
  count()

summary(CalTurmas$n)

## Moda
ModaTurmas <- table(CalTurmas$n)
ModaTurmas[ModaTurmas == max(ModaTurmas)] 





##### RESPOSTAS ------
#Exerc.1
Etnia <- EtapaPEI %>% 
  mutate(ETNIA = case_when(
    TP_COR_RACA %in% 0 ~ "N/D",
    TP_COR_RACA %in% 1 ~ "Branca",
    TP_COR_RACA %in% 2 ~ "Preta",
    TP_COR_RACA %in% 3 ~ "Parda",
    TP_COR_RACA %in% 4 ~ "Amarela",
    TP_COR_RACA %in% 5 ~ "Indígena",
  )
  )
table(Etnia$ETNIA)


#Exerc.2
TurnoEtapaEtnia <- MatTurma %>% 
  mutate(ETAPA = case_when(
    FK_COD_ETAPA_ENSINO %in% 25:29 ~ "EM",
    FK_COD_ETAPA_ENSINO %in% 45 ~ "EJA",
  ),
  TURNO = case_when(
    HR_INICIAL %in% 7:8 ~ "Manhã",
    HR_INICIAL %in% 19 ~ "Noite",
  ),
  ETNIA = case_when(
    TP_COR_RACA %in% 0 ~ "N/D",
    TP_COR_RACA %in% 1 ~ "Branca",
    TP_COR_RACA %in% 2:3 ~ "Negra",
    TP_COR_RACA %in% 4 ~ "Amarela",
    TP_COR_RACA %in% 5 ~ "Indígena",
  )
  )
table(TurnoEtapaEtnia$ETAPA)
table(TurnoEtapaEtnia$TURNO)
table(TurnoEtapaEtnia$ETNIA)


# Exerc.3
CrossEscMat <- table(PK_COD_ENTIDADE, ETAPA)
CrossEscMat
