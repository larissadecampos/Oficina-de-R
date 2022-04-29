# cerquilha/jogo-da-velha/hash utilizado para fazer comentários, o código não é lido pelo console do R
# aspas " " e '' também para comentários

"comentário aleatório"

# aspas são utilizadas também em funções

#Comandos básicos no R
1+1
2-1
3*4
6/3

2^3 #potenciação

5 %/%2 #divisão de números inteiros



2+1==3 #verdadeiro
2==3 #falso


2<=3
2>=3



# "<-" e "=" utilizados para criar objetos 
x<- 5
x+2

x = 4


  
# () parênteses são utilizados em funções
função(argumento,argumento)

x<- c(1,2,3) # c é uma função para concatenar elementos
# se tudo estiver em parentesis o R 'imprime' o objeto

(x<- c(1,2,3))
x
print(x)

x #erro


# : algo como "até"
1:20

x<- 20:30


# [] dá acesso aos elementos de um objeto

x[3]

# Operadores lógicos

x[x>25]
x[x<25]

x[x>22 & x<28] # x maior que 22 E menor que 28
x[x<23 | x>27] # x menor que 23 OU maior que 27

x[x>22 & x!=28]

# funções dentro de funções
# algo semelhante a operações aritméticas
# plot cria um gráfico
x+ 1
(x+1)* 2

plot(x)
plot(x^10)log(x)
plot(log(x))

