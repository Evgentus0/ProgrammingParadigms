:- encoding(utf8).
:- dynamic have_found/1.
do_consulting:- find, have_found(X),!,nl,
        write("Об'єкт ідентифікується як "),
        write(X),write("."),nl,clear_facts.

do_consulting:- nl,write("Вибачте, ми не можемо Вам допомогти!"),
        nl, clear_facts.

find:- test1(X), test2(X,Y), test3(X,Y,Z), test4(X,Y,Z,P), test5(X,Y,Z,P,K), test6(X,Y,Z,P,K,M), test7(X,Y,Z,P,K,M,E),!.
find.

clear_facts:- retract(have_found(_)), fail.
clear_facts.

has_it(X):- write("Чи ідентифікований об'єкт "),
            write(X),write(" (y/n)? -\n"),readln(R),R=[y].

test1(y):-has_it("є видом спорту"),!.
test1(n).

test2(y,y):- has_it("використовує м'яч"), assertz(have_found("регбі")),!.
test2(y,n):- assertz(have_found("роліковивй спорт")),!.

test2(n,y):- has_it("є вченим"),!.
test2(n,n):-!.

test3(n,y,y):- has_it("є математиком"), assertz(have_found("Роберт Рекорд")),!.
test3(n,y,n):- assertz(have_found("Рене Декарт")),!.

test3(n,n,y):- has_it("є блюдом"),!.
test3(n,n,n):-!.

test4(n,n,y,y):- has_it("є блюдом з лапшою"), assertz(have_found("Рамен")),!.
test4(n,n,y,n):- assertz(have_found("Равіолі")),!.

test4(n,n,n,y):- has_it("є мінералом"),!.
test4(n,n,n,n):- !.

test5(n,n,n,y,y):- has_it("є гідроксилкарбонат міді "), assertz(have_found("розазит")),!.
test5(n,n,n,y,n):- assertz(have_found("ренгеїт")),!.

test5(n,n,n,n,y):- has_it("є країною"),!.
test5(n,n,n,n,n):- clear_facts.

test6(n,n,n,n,y,y):- has_it("є найбільшою країною у світі"), assertz(have_found("Росія")),!.
test6(n,n,n,n,y,n):- !.

test7(n,n,n,n,y,n,y):- has_it("є країною у Європі"), assertz(have_found("Румунія")), !.
test7(n,n,n,n,y,n,n):- assertz(have_found("Рванда")),!.