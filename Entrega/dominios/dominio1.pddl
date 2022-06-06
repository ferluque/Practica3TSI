(define (domain StarcraftDom1)

    (:requirements
        :equality
        :negative-preconditions
        :typing
    )

    (:types
        ; Ejercicio 1
        fijos loc movibles - object
        recurso edificio - fijos
        unidad - movibles
        tipoedificio tipounidad - object
    )

    (:constants
        ; Ejercicio 1
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
        (tipo_ed ?e - edificio ?t - tipoedificio)
    )

    (:action Navegar
        :parameters (?u - unidad ?orig ?dest - loc)
        :precondition (and 
                        ; Para que una unidad se mueva debe estar en una posición y moverse a una colindante
                        (ud_en ?u ?orig)
                        (conecta ?orig ?dest))
        :effect (and 
                (ud_en ?u ?dest)
                (not (ud_en ?u ?orig)))
    )
    
    ; No se permite desasignar un VCE una vez que ya se haya asignado
    (:action Asignar
        :parameters (?u - unidad ?lrecurso - loc ?recurso - recurso)
        :precondition(and
                        ; Para asignarla debe estar en el nodo indicado y que en ese nodo haya ese recurso
                        (tipo ?u VCE)
                        (ud_en ?u ?lrecurso)
                        (en ?recurso ?lrecurso))
        :effect (and (extrayendo ?u ?recurso))
    )
)