(define (problem Ejercicio2)
    (:domain StarcraftDom2)
    (:objects 
        LOC11,LOC12,LOC13,LOC14,LOC21,LOC22,LOC23,LOC24,LOC31,LOC32,LOC33,LOC34,LOC44 - loc
        VCE1, VCE2 - unidad
        Extractor1 - edificio
        CentroDeMando1 - edificio
    )
    (:init
        (tipo_ed Extractor1 Extractor)
        (tipo_ed CentroDeMando1 CentroDeMando)
        (construido CentroDeMando1 LOC11)

        (tipo VCE1 VCE)
        (tipo VCE2 VCE)

        (ud_en VCE1 LOC11)
        (ud_en VCE2 LOC11)

        (en Minerales LOC22)
        (en Minerales LOC32)

        (en GasVespeno LOC44)
        
        (necesita Extractor1 Minerales)
        
        (conecta LOC11 LOC12)
        (conecta LOC12 LOC11)
        
        (conecta LOC11 LOC21)
        (conecta LOC21 LOC11)
        
        (conecta LOC12 LOC22)
        (conecta LOC22 LOC12)
        
        (conecta LOC21 LOC31)
        (conecta LOC31 LOC21)
        
        (conecta LOC22 LOC32)
        (conecta LOC32 LOC22)
        
        (conecta LOC31 LOC32)
        (conecta LOC32 LOC31)
        
        (conecta LOC22 LOC23)
        (conecta LOC23 LOC22)
        
        (conecta LOC23 LOC13)
        (conecta LOC13 LOC23)
        
        (conecta LOC23 LOC33)
        (conecta LOC33 LOC23)

        (conecta LOC13 LOC14)
        (conecta LOC14 LOC13)
        
        (conecta LOC14 LOC24)
        (conecta LOC24 LOC14)
        
        (conecta LOC24 LOC34)
        (conecta LOC34 LOC24)
        
        
        (conecta LOC33 LOC34)
        (conecta LOC34 LOC33)
        
        (conecta LOC34 LOC44)
        (conecta LOC44 LOC34)
    )
    
    (:goal 
        (and (extrayendo VCE2 GasVespeno))
    )
)