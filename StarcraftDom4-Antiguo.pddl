(define (domain StarcraftDom4)

    (:requirements
        :equality
        :negative-preconditions
        :typing
     :disjunctive-preconditions :universal-preconditions)

    (:types
        ; Ejercicio 1
        fijos loc tipoedificio tipounidad movible - object
        recurso edificio - fijos
        unidad - movible
    )

    (:constants
        ; Ejercicio 1
        VCE Marine Soldado - unidad
        CentroDeMando Barracones Extractor - edificio
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
        (extrayendo ?r - recurso)
        (tipo ?u - unidad ?t - unidad)

        ; Ejercicio 2
        (ocupada ?u - unidad)
        (son_minerales ?r - recurso)
        (son_gv ?r - recurso)
        (tipo_ed ?e - edificio ?t - edificio)
        (necesita ?e - edificio ?r - recurso)
        (ud_necesita_rec ?u - unidad ?r - recurso)
        (ud_necesita_ed ?u - unidad ?e - edificio)
)

    (:functions

    )

    (:action Navegar
        :parameters (?u - unidad ?orig ?dest - loc)
        :precondition (and 
                        (ud_en ?u ?orig)
                        (conecta ?orig ?dest))
        :effect (and 
                (ud_en ?u ?dest)
                (not (ud_en ?u ?orig)))
    )
    
    (:action Asignar
        :parameters (?u - unidad ?lrecurso - loc ?recurso - recurso)
        :precondition(and
                        (tipo ?u VCE)
                        (ud_en ?u ?lrecurso)
;                        (en ?recurso ?lrecurso)
                        (or (en Minerales ?lrecurso)
                        (and (
                            imply (en GasVespeno ?lrecurso)(
                                exists (?x - edificio)(and (construido ?x ?lrecurso) (tipo_ed ?x Extractor)))
                        ))
                        )
                    )
        :effect (and (extrayendo ?recurso)(ocupada ?u))
    )

    (:action Construir
        :parameters (?u - unidad ?e - edificio ?l - loc)
        :precondition (and 
                        (ud_en ?u ?l)
                        (not (ocupada ?u))
                        (not (exists (?lo - loc)(construido ?e ?lo)))
                        (tipo ?u VCE)
                        (forall (?ed - edificio)(not(construido ?ed ?l)))
                        (exists (?tipo - edificio)(
                            and (tipo_ed ?e ?tipo)(forall (?tiporec - recurso)(
                                imply (necesita ?tipo ?tiporec)(extrayendo ?tiporec)                                   
                                )
                            ))
                        )
                        ; Añadir que tiene que haber gas para extractor
                    )
        :effect (and (construido ?e ?l))
    )

    (:action Reclutar
        :parameters (?e - edificio ?u - unidad ?l - loc)
        :precondition (and 
            (exists (?tipounidad - unidad)(and (tipo ?u ?tipounidad)(
                forall (?rec - recurso)(
                    imply (ud_necesita_rec ?tipounidad ?rec)(
                        extrayendo ?rec
                    )
                )
            )))
            (exists (?tipounidad - unidad)(and (tipo ?u ?tipounidad)(
                forall (?tipoed - edificio)(
                    imply (ud_necesita_ed ?tipounidad ?tipoed)(
                        and (tipo_ed ?e ?tipoed)(construido ?e ?l)
                    )
                )
            )))
        )
        :effect (and (ud_en ?u ?l))
    )  
)

