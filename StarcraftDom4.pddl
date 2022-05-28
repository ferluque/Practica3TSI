(define (domain StarcraftDom4)

    (:requirements
        :equality
        :negative-preconditions
        :typing
     :disjunctive-preconditions :universal-preconditions)

    (:types
    ; Fijos no se mueven
    ; Movibles (unidad) sí
    ; Recurso no tiene objetos concretos, solo los tipos genericos
        fijos loc movibles - object
        recurso edificio - fijos
        unidad - movibles
        tipoedificio tipounidad - object
    )

    (:constants
        VCE Marine Soldado - tipounidad
        CentroDeMando Barracones Extractor - tipoedificio
        Minerales GasVespeno - recurso
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
        (tipo ?u - unidad ?t - tipounidad)

        ; Ejercicio 2
        (ocupada ?u - unidad)
    (tipo_ed ?e - edificio ?t - tipoedificio)
        (necesita ?e - tipoedificio ?r - recurso)

        ; Ejercicio 4
        (reclutado_en ?u - tipounidad ?ed - tipoedificio)
        (ud_necesita_rec ?u - tipounidad ?r - recurso)
)

    (:functions

    )

    (:action Navegar
        :parameters (?u - unidad ?orig ?dest - loc)
        :precondition (and 
                        (ud_en ?u ?orig)
                        (conecta ?orig ?dest)
                        (not (ocupada ?u)))
        :effect (and 
                (ud_en ?u ?dest)
                (not (ud_en ?u ?orig)))
    )
    
    (:action Asignar
        :parameters (?u - unidad ?lrecurso - loc ?recurso - recurso)
        :precondition(and
                        (tipo ?u VCE)
                        (ud_en ?u ?lrecurso)
                        (en ?recurso ?lrecurso)
                        (or (en Minerales ?lrecurso)
                        (and (
                            imply (en GasVespeno ?lrecurso)(
                                exists (?x - edificio)(and (construido ?x ?lrecurso) (tipo_ed ?x Extractor)))
                        ))
                        )
                    )
        :effect (and (extrayendo ?u ?recurso)(ocupada ?u))
    )

    (:action Construir
        :parameters (?u - unidad ?e - edificio ?l - loc)
        :precondition (and 
                        (ud_en ?u ?l)
                        (not (ocupada ?u))
                        (imply (tipo_ed ?e Extractor)(en Minerales ?l))
                        (not (exists(?lo - loc)(construido ?e ?lo)))
                        (forall (?ed - edificio)(not(construido ?ed ?l)))
                        (exists (?tipo - tipoedificio)(
                            and (tipo_ed ?e ?tipo)(forall (?rec - recurso)(
                                imply (necesita ?tipo ?rec)(;extrayendo ?rec
                                    exists (?ud - unidad)(extrayendo ?ud ?rec)
                                )
                            ))
                        ))
                        )
        :effect (and (construido ?e ?l))
    )

    (:action Reclutar
        :parameters (?e - edificio ?u - unidad ?l - loc)
        :precondition (and 
                    ; Su tipo de unidad
                    (exists (?tipounidad - tipounidad)(and (tipo ?u ?tipounidad)(
                        forall (?tipoed - tipoedificio)(
                            imply (reclutado_en ?tipounidad ?tipoed)(
                                and (tipo_ed ?e ?tipoed)(construido ?e ?l)
                            )
                        )
                    )))
                    ; Su tipo de unidad
                    (exists (?tipounidad - tipounidad)(and (tipo ?u ?tipounidad)(
                        forall (?rec - recurso)(
                            imply (ud_necesita_rec ?tipounidad ?rec)(
                                exists(?ud - unidad)(extrayendo ?ud ?rec)
                            )
                        )
                    )))
        )
        :effect (and (ud_en ?u ?l))
    )
    
)

