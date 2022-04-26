library("tidyverse")
library("haven")

###Importando dados do SPSS --- Read é importação

EscolasSPSS <- read_sav("c:/Users/laris/Desktop/Nova pasta/2012Escolas.sav")

### CSV --- rodar Crtl+Enter linha a linha

EscolasSP <- read.delim("c:/Users/laris/Desktop/Nova pasta/Escolas_SP.csv", sep =",") ##definindo separador
EscolasSP1 <- read.csv("c:/Users/laris/Desktop/Nova pasta/Escolas_SP.csv") ##com vírgula
EscolasSP2 <- read.csv2("c:/Users/laris/Desktop/Nova pasta/Escolas_SP.csv") ##com ponto e vírgula


### Excel
library("readxl")

CodMunicipios <- read_sav ("c:/Users/laris/Desktop/Nova pasta/CodMunicipios.xlsx")

## Removendo dados
remove(EscolasSP2,EscolasSP)

## Manipulando dos dados # filter
glimpse(EscolasSP1)## ferramenta pra gente ver as variáveis
SalasUtil <- EscolasSP1 %>% filter(NUM_SALAS_UTILIZADAS >5)

Funcionarios <- EscolasSP1 %>% filter(NUM_FUNCIONARIOS < 20)
Funcionarios2 <- EscolasSP1 %>% filter(NUM_FUNCIONARIOS <= 20)
Funcionarios3 <- EscolasSP1 %>% filter(!NUM_FUNCIONARIOS < 20) ## tudo que for maior que o vinte inclusive o 20

## Exercício 01

## Criar a variável 'Computadores' com as escolas que possuem mais de 10 máquinas
Computadores <- EscolasSP1 %>% filter (NUM_COMPUTADORES >10)


remove(Funcionarios2,Funcionarios3)


## Operadores lógicos

PrivadaFuncionarios <- EscolasSP1 %>% filter (ID_DEPENDENCIA_ADM == 4 & NUM_FUNCIONARIOS < 15)
NaoPrivada <- EscolasSP1 %>% filter (ID_DEPENDENCIA_ADM != 4) ##privada

## Exercício 02
## Criar a variável 'PrivadaComPC' com as escolas privadas que tem até 20 computadores

PrivadaComPc <- EscolasSP1 %>% filter (ID_DEPENDENCIA_ADM == 4 & NUM_COMPUTADORES <= 20)


##Salvando
## %>% pipe

EscolasCapital <- EscolasSP1  %>% filter(FK_COD_MUNICIPIO == 3550308)
write.csv2(EscolasCapital, "c:/Users/laris/Desktop/Nova pasta/EscolasCapital.csv")

### Estatística
## Média  
#Função - objeto - variável
mean(Funcionarios$NUM_FUNCIONARIOS)

# Máximo
max(Funcionarios$NUM_FUNCIONARIOS)

# Mínimo
min (Funcionarios$NUM_FUNCIONARIOS)

# Desvio Padrão
sd (Funcionarios$NUM_FUNCIONARIOS)

# Resumo Estatístico ---------------  mais usados ---------------
summary (Funcionarios$NUM_FUNCIONARIOS)

# Frequência básica - quantidade de coisas por categoria
table (EscolasSP1$ID_DEPENDENCIA_ADM)



### Iniciando os trabalhos 
# Abrir Matrículas(sav) 2012
# Selecionar escolas PEI
# Ler freqência de matrículas por etapa escolar



Mat12 <- read_sav("c:/Users/laris/Desktop/Nova pasta/2012Mat_SP-EEs.sav")
glimpse(Mat12) ## para saber como a variável aparece

flag <- Mat12 %>%  ##Objeto #Acrescentar uma coluna com esse conjunto se ele for verdadeiro é 1 se não 0. Tipo PROCV
  mutate(flag_pei = PK_COD_ENTIDADE %in% c('35003669','35003700','35028794','35028915','35029178','35012191','35013365','35019720',
                                            '35049499','35462378','35462342','35442550','35005548','35005551','35040548','35462330'))
