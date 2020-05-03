schedule(monday, programming).
schedule(tuesday, match).
schedule(tuesday, english).
schedule(wednesday, programming).
schedule(wednesday, spanish).
schedule(thursday, circuits).
schedule(friday, none).

difficulty(programming, hard).
difficulty(match, hard).
difficulty(english, easy).
difficulty(spanish, medium).
difficulty(circuits, hard).


classInformation(Day, Class, Diff) :-
    schedule(Day, Class),
    difficulty(Class, Diff).
