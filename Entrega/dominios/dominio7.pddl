(define (domain StarcraftDom7)

    (:requirements
        :equality
        :negative-preconditions
        :typing
     :disjunctive-preconditions :universal-preconditions :fluents :conditional-effects)

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
        (ya_construido ?e - edificio)
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
        
        (necesita ?e - tipoedificio ?r - recurso)
        (ud_necesita_rec ?u - tipounidad ?r - recurso)

        ; Este es un predicado genérico que sustituye al (exists (?l - loc)(ud_en ?u ?l)) para acelerar la búsqueda
        (ya_reclutado ?u - unidad)
)

    (:functions
        ; Cantidad de un recurso en los almacenes
        (cantidad ?r - recurso)
        ; Cantidad de VCES asignados a un recurso en una localizacion
        (asignados ?r - recurso ?lrecurso - loc)
        ; Cantidad de recurso que necesita un edificio para construirse
        (ed_necesita_tantos ?e - tipoedificio ?r - recurso)
        ; Cantidad de recurso que ncesita una unidad para reclutarse
        (ud_necesita_tantos ?u - tipounidad ?r - recurso)
        (long_plan)
    )

    (:action Navegar
        :parameters (?u - unidad ?orig ?dest - loc)
        ; Que orig y dest conecten
        ; Que la unidad no esté asignada (las que están extrayendo no se mueven)
        ; Que esté en el origen
        :precondition (and 
                        (ud_en ?u ?orig)
                        (conecta ?orig ?dest)
                        (not (ocupada ?u))
                        (ya_reclutado ?u))
        :effect (and 
                (ud_en ?u ?dest)
                (not (ud_en ?u ?orig))
                (increase (long_plan)1))
    )
    
    (:action Construir
        :parameters (?u - unidad ?e - edificio ?l - loc)
        :precondition (and 
                        (ya_reclutado ?u)
                        ; La unidad esté en la localización
                        (ud_en ?u ?l)
                        ; No ocupada
                        (not (ocupada ?u))
                        ; Un extractor se tiene que construir sobre Gas
                        (imply (tipo_ed ?e Extractor)(en GasVespeno ?l))
                        ; El edificio no está construido en otro sitio
                        (not (ya_construido ?e))
                        ; No hay otro edificio en la localización
                        (forall (?ed - edificio)(not(construido ?ed ?l)))
                        ; Si el edificio es de un tipo
                        (exists (?tipoed - tipoedificio)(
                            and (tipo_ed ?e ?tipoed)(forall (?rec - recurso)(
                                imply (necesita ?tipoed ?rec)(
                                    >= (cantidad ?rec)(ed_necesita_tantos ?tipoed ?rec)
                                ))
                            )
                        ))
        )
        :effect (and (construido ?e ?l)
                (forall (?tipoed - tipoedificio ?r - recurso)(
                    when (and(tipo_ed ?e ?tipoed)(necesita ?tipoed ?r))(
                            decrease (cantidad ?r)(ed_necesita_tantos ?tipoed ?r)
                    )
                ))
                (increase (long_plan)1)
                (ya_construido ?e)  
        )
    )

    (:action Reclutar
        :parameters (?e - edificio ?u - unidad ?l - loc)
        :precondition (and
            ; Para el tipo que sea la unidad
            (exists (?tipoud - tipounidad)(
                and (tipo ?u ?tipoud)(forall (?rec - recurso)(
                    imply (ud_necesita_rec ?tipoud ?rec)(
                        and (>= (cantidad ?rec)(ud_necesita_tantos ?tipoud ?rec))
                    )
                ))
            ))
            (exists (?tipoud - tipounidad ?tipoed - tipoedificio)(and
                ; El tipo de unidad que sea ?u
                (tipo ?u ?tipoud)
                ; Y que sea reclutado en un edificio
                (reclutado_en ?tipoud ?tipoed)
                ; El edificio ?e debe ser de ese tipo
                (tipo_ed ?e ?tipoed)
                ; Y estar construido en la localización
                (construido ?e ?l)
            ))
            ; QUe no esté ya reclutado
            (not (ya_reclutado ?u))
        )
        :effect (and (ud_en ?u ?l)
        (forall (?tipoud - tipounidad ?r - recurso)(
            when (and (tipo ?u ?tipoud)(ud_necesita_rec ?tipoud ?r))(
                    decrease (cantidad ?r)(ud_necesita_tantos ?tipoud ?r)
            )
        ))
        (increase (long_plan)1)
        (ya_reclutado ?u)
        )
    )
    
    ; Ejercicio 7
    (:action Asignar
        :parameters (?u - unidad ?lrecurso - loc ?recurso - recurso)
        :precondition(and
                        (ya_reclutado ?u)
                        ; NO esté asignada
                        (not (ocupada ?u))
                        (tipo ?u VCE)
                        (ud_en ?u ?lrecurso)
                        (en ?recurso ?lrecurso)
                        ; Si el recurso es minerales no necesita nada
                        (or (en Minerales ?lrecurso)
                        (and (
                            ; Si el recurso es GV
                            imply (en GasVespeno ?lrecurso)(
                                ; Tiene que haber un extractor
                                exists (?x - edificio)(and (construido ?x ?lrecurso) (tipo_ed ?x Extractor)))
                        ))
                        )
                    )                                                       ; Se suma uno a los asignados
        :effect (and (extrayendo ?u ?recurso)(extraido ?recurso)(ocupada ?u)(increase (asignados ?recurso ?lrecurso) 1)(increase (long_plan)1))
    )

    (:action Recolectar
        :parameters (?r - recurso ?l - loc)
        :precondition (and 
            ; Debe estar siendo extraido (tiene un VCE asignado)
            (extraido ?r)
            ; Es necesario que esté en ?l el recurso
            (en ?r ?l)
            ; Si al recolectar supera 60 no recolecta
            ; Si (cantidad ?r)+10*(asignados ?r ?l) > 60 no recolecta
            (<= (+ (cantidad ?r)(* 10 (asignados ?r ?l))) 60)

            ; Realmente la condición del extractor es redundante ya que previamente se establece que debe estar siendo extraido
            ; y para que esté siendo extraido ya tenía que haber un extractor. Sin embargo, el añadir estas precondiciones
            ; acelera la búsqueda
            (or (en Minerales ?l)
                        (and (
                            ; Si el recurso es GV
                            imply (en GasVespeno ?l)(
                                ; Tiene que haber un extractor
                                exists (?x - edificio)(and (construido ?x ?l) (tipo_ed ?x Extractor)))
                        ))
            )
        )
        ; Se suman 10 por cada uno asignado
        :effect (and (increase (cantidad ?r)(* 10 (asignados ?r ?l)))(increase (long_plan)1))
    )    
)

