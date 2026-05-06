# Projeto de Programação Lógica - O Alquimista

Este projeto apresenta um jogo de simulação simplificado, referenciando outro jogo chamado "Little Alchemy". O objetivo do jogo é combinar elementos básicos (fogo, terra, água e ar) para formar novas misturas, e ao fim, realizar o "Grande Final": conseguir combinar as três misturas/elemntos que formam a Pedra Filosofal.

## Descrição do jogo
"O Alquimista" é um jogo de terminal que se resume na interação de elementos e misturas definidos por fatos e regras como "misturar/2" ou "ver_inventario". Nele, o jogador tem liberdade de tentar combinar qualquer elemento, mas é necessário estratégia pois a energia do alquimista diminui a cada interação (mana). A descoberta de novos elementos permite acesso a misturas mais complexas. O jogador vence ao conseguir reunir os três elementos necessários para o "Grande Final" que forma a Pedra Filosofal.

## Conceitos utilizados
O código usa conceitos estudados em aula, fundamentais em ProLog:
* Backtracking e Unificação: o predicado "combina/3" permite que independente da ordem informada dos elementos, a receita seja formada. Ex: (Terra + Água) é a mesma coisa que (Água + Terra).
  ```

  ```
* Controle de fluxo: foi utilizado o Cut (!) para implementar o conceito de "Red Cut" ao por exemplo encontrar uma mistura válida, impedindo que o sistema execute a regra de falha.
   ```

  ```
* Agragação: Os comandos "findall/3" e "setof/3" foram usados para coletas todos os fatos dinâmicos espalhados pela memória e apresentar como uma lista organizada, tanto no inventário quanto no sistema de dicas.
   ```

  ```
* Manipulação de listas: No "Grande Final", os comandos "append/3", "length/2" e o "member/2" validam se o jogador inseriu is três elementos necessários para a vitória.
   ```

  ```

## Execução do jogo
1. Comando para inicar o jogo:
   ?- iniciar.
   Saída esperada:

2. Comando para exibir o inventario:
   ?- ver_inventario.
   Saída esperada:

3. Mistura com sucesso:
   ?- misturar(fogo, terra).
   Saída esperada:

4. Regra de dedução lógica:
   ?- misturar(agua, lava).
   Saída esperada:

5. O grande final:
   ?- grande_final([vida, energia], [lava]).
   Saída esperada:

## Conclusão
Este projeto permitiu o desenvolvimento de forma prática dos conceitos aprendidos em aula, mostrando que mesmo em um paradigma declarativo, é possível criar sistemas interativos e complexos. O uso de Cut foi o ponto mais desafiador, por utilizar um conceito sensível como o "Red Cut" foi necessário pensar estrategicamente para que ocorresse o comportamento desejado. 
