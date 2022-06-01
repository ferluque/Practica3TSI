(define (domain StarcraftDom7)

    (:requirements
        :equality
        :negative-preconditions
        :typing
     :disjunctive-preconditions :universal-preconditions :fluents)

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
        (extraido ?r - recurso)
        (tipo ?u - unidad ?t - tipounidad)

        ; Ejercicio 2
        (ocupada ?u - unidad)
        (tipo_ed ?e - edificio ?t - tipoedificio)
        

        ; Ejercicio 4
        (reclutado_en ?u - tipounidad ?ed - tipoedificio)
        
)

    (:functions
        (cantidad ?r - recurso)
        (asignados ?r - recurso ?lrecurso - loc)
        (necesita ?e - tipoedificio ?r - recurso)
        (ud_necesita_rec ?u - tipounidad ?r - recurso)
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
                                    >= (cantidad ?rec) (necesita ?tipo ?rec)                            
                            ))
                        ))
                        )
        :effect (and (construido ?e ?l))
    )

    ; RECLUTAR CENTRODEMANDO1 VCE2 LOC11
    ; EXISTS 
    ; TIPO VCE2 VCE
    ; UD_NECESITA_REC VCE MINERALES
    ; EXTRAIDO MINERALES
    (:action Reclutar
        :parameters (?e - edificio ?u - unidad ?l - loc)
        :precondition (and
            (exists (?tipoud - tipounidad)(
                and (tipo ?u ?tipoud)(forall (?rec - recurso)(
                    >= (cantidad ?rec)(ud_necesita_rec ?tipoud ?rec)))
                )
            )
            (exists (?tipoud - tipounidad ?tipoed - tipoedificio)(and
                (tipo ?u ?tipoud)
                (reclutado_en ?tipoud ?tipoed)
                (tipo_ed ?e ?tipoed)
                (construido ?e ?l)
            ))
        )
        :effect (and (ud_en ?u ?l));(-(cantidad ?rec)(ud_necesita_rec ?tipoud ?rec)));(exists (?tipoud - tipounidad)(forall (?r - recurso))(- (cantidad ?r)(ud_necesita_rec ?tipoud ?r))))
    )
    
    ; Ejercicio 7
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
        :effect (and (extrayendo ?u ?recurso)(extraido ?recurso)(ocupada ?u)(increase (asignados ?recurso ?lrecurso) 1))
    )

    (:action Recolectar
        :parameters (?r - recurso ?l - loc)
        :precondition (and 
            (exists(?u - unidad)(extrayendo ?u ?r))
        )
        :effect (and (increase (cantidad ?r) (* 10 (asignados ?r ?l))))
    )    
)

