# O Problema do Apresentador: Uma Abordagem Estatística para o Problema de Monty Hall

## Sumário

  1. [Introdução](#introdução)
  2. [O problema](#o-problema)
  3. [Porque é melhor trocar de porta](#porque-é-melhor-trocar-de-porta)
  4. [Como o programa funciona](#como-o-programa-funciona)
  5. [Como recriar o experimento](#como-recriar-o-experimento)
  6. [Referências](#referências)

## Introdução

O problema de [Monty Hall](http://clubes.obmep.org.br/blog/probabilidades-o-problema-de-monty-hal/) envolve três portas, sendo que uma delas esconde um prêmio e as outras duas contém um bode. Uma pessoa (ou algum jogador) seleciona uma porta (que ainda não está aberta), e, logo após, outra porta (que não foi a escolhida) é aberta pelo apresentador e mostra que atrás desta havia um bode. Agora, restam duas portas fechadas (uma com o prêmio e outra com outro bode), sendo uma dessas a que o jogador escolheu. Então, depois dessa etapa, o jogador pode decidir se mantém a sua escolha inicial ou se troca de porta. A questão é: <strong> a melhor opção é ficar com a porta que escolheu no começo ou mudar para a outra porta que restou? </strong>

<img src="images/doors.png" alt="três portas com sinais de interrogação."/>

## O problema

Ao analisarmos os eventos possíveis, percebemos o seguinte: como a probabilidade de um evento ocorrer é dada pela razão dos casos favoráveis pelo total de casos, como o jogador que ganhar o prêmio e ele está em uma das três, temos 1 caso favorável (escolher a porta com o prêmio) e três casos totais (as três portas), logo, podemos concluir que temos 1/3 de chance de ganhar ao escolher uma porta aleatória.

<img src="https://latex.codecogs.com/png.image?\inline&space;\large&space;\dpi{150}&space;{\color{White}&space;P&space;=&space;\frac{C_{F}}{C_{T}}}">

Nesse sentido, o grande ponto do problema de Monty Hall é este: <strong> o apresentador deverá abrir uma das portas e revelar que nessa porta há um bode. </strong>

<img src="images/door-goat.png" alt="três portas: uma com uma cabra, duas com interrogações."/>

Por conseguinte, agora sabemos que uma das portas não tem nenhuma chance de ter o prêmio. Ou seja, é intuitivo pensar que agora cada uma das duas portas restantes possuem 50% de chance de ter o prêmio. No entanto, no próximo tópicos será provado o porquê disso não ser verdade.  

## Porque é melhor trocar de porta

Como visto anteriormente, cada porta tem 1/3 de chance de ter o prêmio. No entanto, como apenas uma tem o prêmio, temos 1/3 de chance de acertar (uma porta certa) e 1/3 + 1/3 de chance de errar (duas portas com bodes), ou seja, 2/3 de chance de escolher uma porta com um bode. Logo, a explicação mais rapida é que, como temos mais chance de escolher uma porta errada (2/3 é o dobro de 1/3), é mais provável ganhar se trocar de porta.</br>

Observe, na imagem abaixo, a representação em um digrama de árvore das possibilidades.

<img src="images/tree-graph.png" alt="digrama de ávore das possibilidades do jogo."/>

## Como o programa funciona

Primeiramente, temos uma função que gera um identificador para as portas (1, 2 ou 3). Essa função é implementada da seguinte forma:

```python
def gen_random_door() -> int:
    return random.randint(1, 3)
```

A função monty_hall_game utiliza a função anterior para definir as portas escolhidas e premiadas. Dependendo da escolha de trocar ou não de porta, o resultado é avaliado:

```python
def monty_hall_game(switch: bool) -> bool:
    prize_door = gen_random_door()
    first_choice = gen_random_door()
    if switch:
        return prize_door != first_choice
    else:
        return first_choice == prize_door
```

A função anterior retorna 'True' ou 'False', se o jogador tiver ganhado ou perdido, respectivamente.

Após isso, é definida uma amostra pro experimento (quantidade de jogos/partidas):

```python
NUM_GAMES = 1_000_000
```

> [!WARNING]
> Note que quanto maior a amostra mais tempo levará para rodar todos os casos.

O programa então escreve os resultados dessas partidas em um arquivo csv (montyhall.csv), onde cada linha é uma iteração de uma partida trocando e outra permanecendo com a mesma porta:

```python
with open("montyhall.csv", mode="w") as f:
    w = csv.writer(f)
    w.writerow(["stay", "change"])
    for _ in range(NUM_GAMES):
        w.writerow([monty_hall_game(False), monty_hall_game(True)])

```

## Como recriar o experimento

## Referências

1. Paradoxo de Monty Hall. Universidade Federal do Rio Grande do Sul. Acesso em 23 de jun. de 2023. Disponível em: <https://www.ufrgs.br/wiki-r/index.php?title=Paradoxo_de_Monty_Hall>
2. Monty Hall Problem. Brilliant.org. Acesso em 25 de jun. de 2023. Disponível em: <https://brilliant.org/wiki/monty-hall-problem/>
3. Edward R. Scheinerman (2003). Matemática Discreta - Uma Introdução 1 ed. Brasil: Cengage Learning. 532 páginas. [ISBN](https://pt.wikipedia.org/wiki/International_Standard_Book_Number) 85-221-0291-0
4. Boechat, Gabriel. Simulação do problema de Monty Hall em R. Open Code Community. Acesso em 27 de jun. de 2023. Disponível em: <https://opencodecom.net/post/2021-04-25-simulacao-do-problema-de-monty-hall-em-r>
5. Probabilidades – O problema de Monty Hall. Acesso em 4 de set. de 2024. Disponível em: <http://clubes.obmep.org.br/blog/probabilidades-o-problema-de-monty-hal/>
