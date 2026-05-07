:- dynamic inventario/1.
:- dynamic mana/1.

% fatos
receita(agua, terra, lama).
receita(fogo, terra, lava).
receita(fogo, ar, energia).
receita(agua, ar, chuva).
receita(chuva, terra, planta).
receita(lama, planta, pantano).
receita(energia, pantano, vida).

combina(E1, E2, Res) :- receita(E1, E2, Res).
combina(E1, E2, Res) :- receita(E2, E1, Res).

% iniciar
iniciar :-
retractall(inventario(_)),
retractall(mana(_)),
assertz(inventario(agua)),
assertz(inventario(fogo)),
assertz(inventario(terra)),
assertz(inventario(ar)),
assertz(mana(20)),
write('======================================='), nl,
write('    BEM-VINDO AO ALQUIMISTA LÓGICO     '), nl,
write('======================================='), nl,
write('Você começa com: agua, fogo, terra, ar.'), nl,
write('Comandos disponíveis:'), nl,
write(' - misturar(Item1, Item2).'), nl,
write(' - ver_inventario.'), nl,
write(' - ver_dicas.'), nl,
write(' - grande_final([Itens1], [Itens2]).'), nl, nl.


misturar(_, _) :-
mana(M), M < 2,
( (inventario(vida), inventario(energia), inventario(lava)) ->
write('Sua mana acabou, mas o Grande Final ainda e possivel!'), nl
;
write('mana esgotada, misturas insuficientes, reinicie o jogo'), nl
), !, fail.

misturar(E1, E2) :-
(not(inventario(E1)) ; not(inventario(E2))),
write('Você não possui um desses elementos no inventário.'), nl, !, fail.

misturar(E1, E2) :-
mana(M),
NovaMana is M - 2,
retract(mana(M)),
assertz(mana(NovaMana)),
processar_mistura(E1, E2).



processar_mistura(E1, E2) :-
combina(E1, E2, NovoItem),
not(inventario(NovoItem)),
assertz(inventario(NovoItem)),
format('SUCESSO! ~w e ~w reagiram e você criou: ~w~n', [E1, E2, NovoItem]),
mana(M), format('Mana restante: ~w~n', [M]),
!.

processar_mistura(E1, E2) :-
combina(E1, E2, NovoItem),
inventario(NovoItem),
write('Você já possui esse item no inventário. Tente ser mais criativo!'), nl,
!.

processar_mistura(lava, _) :-
not(inventario(cinzas)), assertz(inventario(cinzas)),
write('CUIDADO! A lava incinerou o outro item. Você obteve: cinzas.'), nl, !.

processar_mistura(_, lava) :-
not(inventario(cinzas)), assertz(inventario(cinzas)),
write('CUIDADO! A lava incinerou o outro item. Você obteve: cinzas.'), nl, !.

processar_mistura(_, _) :-
write('A mistura falhou. Uma gosma inútil se formou e evaporou.'), nl.




ver_inventario :-
( setof(X, inventario(X), ListaOrdenada) ->
true
;
ListaOrdenada = []
),
write('--- SEU GRIMÓRIO (Inventário) ---'), nl,
( ListaOrdenada == [] ->
write('Seu inventário está completamente vazio!'), nl
;
write(ListaOrdenada), nl
),
( mana(M) -> format('Mana Atual: ~w~n', [M]) ; write('Mana não inicializada.'), nl ),
findall(I, inventario(I), Todos),
length(Todos, Qtd),
format('Total de elementos descobertos: ~w~n', [Qtd]).



ver_dicas :-
findall(Alvo, (receita(_, _, Alvo), not(inventario(Alvo))), ListaBruta),
sort(ListaBruta, DicasUnicas),
write('--- VISÕES DO FUTURO ---'), nl,
( DicasUnicas == [] ->
write('Não há mais receitas básicas para descobrir. É hora de focar no Grande Final!'), nl
;
write('O universo sussurra que você ainda pode transmutar os seguintes elementos:'), nl,
write(DicasUnicas), nl
).




grande_final(Lista1, Lista2) :-
append(Lista1, Lista2, Caldeirao),
length(Caldeirao, Tamanho),
(Tamanho =:= 3 ->
verificar_pedra(Caldeirao)
;
write('O ritual do Grande Final exige a união de EXATAMENTE 3 ingredientes!'), nl
).

verificar_pedra(Caldeirao) :-
(member(vida, Caldeirao), member(energia, Caldeirao), member(lava, Caldeirao) ->
( not(inventario(pedra_filosofal)) ->
assertz(inventario(pedra_filosofal)),
write('======================================='), nl,
write('               PARABÉNS!               '), nl,
write('Você transmutou os elementos primordiais'), nl,
write(' e criou a lendária PEDRA FILOSOFAL!   '), nl,
write('======================================='), nl
;
write('Você já alcançou a glória máxima e possui a Pedra Filosofal.')
)
;
write('Os elementos no caldeirão reagiram mal e explodiram. Essa não é a receita final.'), nl
).