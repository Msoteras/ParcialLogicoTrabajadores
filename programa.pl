% Aquí va el código.

%functores tareas
%tomarExamen(tema, lugar).
%hacerUnDiscurso(lugar, cantidadpublico).
%meterUnGol(torneo).

%hizo(Persona, Tarea).
%fueRealizadaEn(Persona,Tarea,fecha(dia,mes,anio)).
%nacio(Persona, lugar).

nacio(alf, buenosAires).
nacio(dani, buenosAires).
nacio(nico, buenosAires).

fueRealizadaEn(dani, tomarExamen(logico, aula522), fecha(10,8,2017)).
fueRealizadaEn(dani, meterUnGol(primeraDivison), fecha(10,8,2017)).
fueRealizadaEn(alf, hacerUnDiscurso(utn,0), fecha(11,8,2017)).
hizo(Persona,Tarea):- fueRealizadaEn(Persona, Tarea, _).

%% quedaEn(lugar, lugar)
quedaEn(venezuela, america).
quedaEn(argentina, america).
quedaEn(patagonia, argentina).
quedaEn(aula522, utn). % Sí, un aula es un lugar!
quedaEn(utn, buenosAires).
quedaEn(buenosAires, argentina).
quedaEn(primeraDivison, buenosAires).


%Punto 1

nuncaSalioDeCasa(Persona):-
    hizo(Persona,_),
    nacio(Persona, Lugar),
    forall(hizo(Persona,Tarea),tareaSeHizoEn(Tarea, Lugar)).

tareaSeHizoEn(tomarExamen(_, LugarTarea), Lugar):-
    quedaEn2(LugarTarea, Lugar).
tareaSeHizoEn(hacerUnDiscurso(LugarTarea, _), Lugar):-
    quedaEn2(LugarTarea, Lugar).
tareaSeHizoEn(meterUnGol(Torneo), Lugar):-
    quedaEn2(Torneo, Lugar).

quedaEn2(LugarChico, LugarGrande) :- 
    quedaEn(LugarChico, LugarGrande).
 
 quedaEn2(LugarChico, LugarGrande) :- 
    quedaEn(LugarChico, LugarMediano),
    quedaEn2(LugarMediano, LugarGrande).

%Punto 2
esEstresante(Tarea):-
    hizo(_, Tarea),
    tareaSeHizoEn(Tarea,argentina),
    criterio(Tarea). 

criterio(hacerUnDiscurso(_,Espectadores)):- Espectadores > 30000.
criterio(tomarExamen(Tema,_)):- esComplejo(Tema).
criterio(meterUnGol(_)).

esComplejo(logico).

%Punto 3
calificacion(Persona, zen):-
    not(hizoTareaEstresante(Persona,_)).
    forall(hizo(Persona,Tarea), not(esEstresante(Tarea))).
calificacion(Persona, locos):-
    forall(fueRealizadaEn(Persona,Tarea,fecha(_,_,2017)), esEstresante(Tarea)).
calificacion(Persona,sabio):-
    hizoTareaEstresante(Persona,Tarea),
    not(hizoTareaEstresante(Persona,OtraTarea), Tarea \= OtraTarea).

hizoTareaEstresante(Persona):-
    hizo(Persona,Tarea), 
    esEstresante(Tarea).

%Punto 4
estresDeTodosLosTiempos(Ganador):-
    tareasEstresantes(Ganador, CantTareasEstresantes),
    forall((tareasEstresantes(Perdedor, CantTareasEstresantes2), Ganador \= Perdedor), CantTareasEstresantes > CantTareasEstresantes2).

tareasEstresantes(Persona, CantidadTareas):-
    hizo(Persona,_),
    findall(TareaEstresante,(hizo(Persona,TareaEstresante), esEstresante(TareaEstresante)), Tareas),
    length(Tareas, CantidadTareas).

%Punto 5 Teorico
