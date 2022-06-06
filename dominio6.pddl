(define (domain StarcraftDom6)

    (:requirements
        :equality
        :negative-preconditions
        :typing
        :fluents
     :disjunctive-preconditions :universal-preconditions)

    (:types
    ; Fijos no se mueven
    ; Movibles (unidad) sí
    ; Recurso no tiene objetos concretos, solo los tipos genericos
        fijos loc movibles investigacion - object
        recurso edificio - fijos
        unidad - movibles
        tipoedificio tipounidad - object
    )

    (:constants
        VCE Marine Soldado - tipounidad
        CentroDeMando Barracones Extractor BahiaIngenieria - tipoedificio
        Minerales GasVespeno - recurso
        InvSoldadoUniversal - investigacion
    )

    (:predicates
        ; Ejercicio 1
        ;; Primer punto
        (ud_en ?u - unidad ?x - loc)
        ;; Segundo punto
        (conecta ?x - loc ?y - loc)
        ;; Tercer punto
        (construido ?e - edificio ?l - loc)
        ;; Cuarto punto
        (en ?o - fijos ?x - loc)
        ;; Quinto punto
        (extrayendo ?u - unidad ?r - recurso)
        (extraido ?r - recurso)
        (tipo ?u - unidad ?t - tipounidad)

        ; Ejercicio 2
        (ocupada ?u - unidad)
    (tipo_ed ?e - edificio ?t - tipoedificio)
        (necesita ?e - tipoedificio ?r - recurso)

        ; Ejercicio 4
        (reclutado_en ?u - tipounidad ?ed - tipoedificio)
        (ud_necesita_rec ?u - tipounidad ?r - recurso)

        ;Ejercicio 5
        (inv_necesita ?i - investigacion ?r - recurso)
        (investigada ?i - investigacion)
)

    (:functions
        (long_plan)
    )

    (:action Navegar
        :parameters (?u - unidad ?orig ?dest - loc)
        :precondition (and 
                        (ud_en ?u ?orig)
                        (conecta ?orig ?dest)
                        (not (ocupada ?u)))
        :effect (and 
                (ud_en ?u ?dest)
                (not (ud_en ?u ?orig))
                (increase (long_plan) 1)
                )
    )
    
    (:action Asignar
        :parameters (?u - unidad ?lrecurso - loc ?recurso - recurso)
        :precondition(and
                        (tipo ?u VCE)
                        (ud_en ?u ?lrecurso)
                        (en ?recurso ?lrecurso)
                        (not (extraido ?recurso))
                        (or (en Minerales ?lrecurso)
                        (and (
                            imply (en GasVespeno ?lrecurso)(
                                exists (?x - edificio)(and (construido ?x ?lrecurso) (tipo_ed ?x Extractor)))
                        ))
                        )
                    )
        :effect (and (extrayendo ?u ?recurso)(extraido ?recurso)(ocupada ?u)(increase (long_plan) 1))
    )

    (:action Construir
        :parameters (?u - unidad ?e - edificio ?l - loc)
        :precondition (and 
                        (ud_en ?u ?l)
                        (not (ocupada ?u))
                        (imply (tipo_ed ?e Extractor)(en GasVespeno ?l))
                        (not (exists(?lo - loc)(construido ?e ?lo)))
                        (forall (?ed - edificio)(not(construido ?ed ?l)))
                        (exists (?tipo - tipoedificio)(
                            and (tipo_ed ?e ?tipo)(forall (?rec - recurso)(
                                imply (necesita ?tipo ?rec)(;extrayendo ?rec
                                    extraido ?rec
                                )
                            ))
                        ))
                        )
        :effect (and (construido ?e ?l)(increase (long_plan) 1))
    )

    (:action Reclutar
        :parameters (?e - edificio ?u - unidad ?l - loc)
        :precondition (and 
            (not (exists (?loc - loc)(ud_en ?u ?loc)))
            (exists (?tipoud - tipounidad)(
                forall (?rec - recurso)(imply (ud_necesita_rec ?tipoud ?rec)
                    (extraido ?rec)
                )
            ))
            (exists (?tipoud - tipounidad ?tipoed - tipoedificio)(and
                (tipo ?u ?tipoud)
                (reclutado_en ?tipoud ?tipoed)
                (tipo_ed ?e ?tipoed)
                (construido ?e ?l)
            ))
            (imply (tipo ?u Soldado)(investigada InvSoldadoUniversal))
        )
        :effect (and (ud_en ?u ?l)(increase (long_plan) 1))
    )
    
    (:action Investigar
        :parameters (?e - edificio ?i - investigacion)
        :precondition (and 
            (tipo_ed ?e BahiaIngenieria)
            (exists (?l - loc)(construido ?e ?l))
            (forall (?r - recurso)(imply (inv_necesita ?i ?r)(
                extraido ?r
            )))
        )
        :effect (and (investigada ?i)(increase (long_plan) 1))
    )
    

    
)

