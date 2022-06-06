(define (domain StarcraftDom2)

    (:requirements
        :equality
        :negative-preconditions
        :typing
     :disjunctive-preconditions)

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
        VCE - tipounidad
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
        (extrayendo ?v - unidad ?r - recurso)
        (tipo ?u - unidad ?t - tipounidad)

        ; Ejercicio 2
        (ocupada ?u - unidad)
        (tipo_ed ?e - edificio ?t - tipoedificio)
        (necesita ?e - edificio ?r - recurso)
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
                        ; O son minerales
                        (or 
                        (en Minerales ?lrecurso)
                        ; O gas y se ha construido un extractor previamente
                        (and (en GasVespeno ?lrecurso)(exists (?x - edificio)(and (construido ?x ?lrecurso) (tipo_ed ?x Extractor)))))
                        )
        :effect (and (extrayendo ?u ?recurso)(ocupada ?u))
    )

    (:action Construir
        :parameters (?u - unidad ?e - edificio ?l - loc ?r - recurso)
        :precondition (and 
                        ; La unidad debe estar en la zona
                        (ud_en ?u ?l)
                        ; El recurso que se necesite debe estar siendo extraído
                        (exists(?x - unidad)(extrayendo ?x ?r))
                        ; La unidad no puede estar ya asignada
                        (not (ocupada ?u))
                        ; Debe necesitar el recurso que se le indica
                        (necesita ?e ?r)
                        ; Si es un extractor, solo se puede construir sobre un nodo de GV
                        (imply (tipo_ed ?e Extractor)(and (en GasVespeno ?l)))
                        )
        :effect (and (construido ?e ?l))
    )
)