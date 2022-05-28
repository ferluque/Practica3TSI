(define (problem Ejercicio4)
    (:domain StarcraftDom4)

    (:objects 
        LOC11,LOC12,LOC13,LOC14,LOC21,LOC22,LOC23,LOC24,LOC31,LOC32,LOC33,LOC34,LOC44 - loc
        VCE1, VCE2, VCE3 Marine1, Marine2, Soldado1 - unidad
        Extractor1 CentrodeMando1 - edificio
        Barracones1 - edificio
    )
    (:init
        (tipo_ed Extractor1 Extractor)
        (tipo_ed Barracones1 Barracones)
        (tipo VCE1 VCE)
        (tipo VCE2 VCE)
        (tipo VCE3 VCE)
        (tipo Marine1 Marine)
        (tipo Marine2 Marine)
        (tipo Soldado1 Soldado)
        (tipo_ed CentrodeMando1 CentroDeMando)

        (son_minerales Minerales)
        (son_gv GasVespeno)

        (ud_en VCE1 LOC11)

        (ud_necesita_rec Marine Minerales)
        (ud_necesita_rec VCE Minerales)

        (ud_necesita_rec Soldado Minerales)
        (ud_necesita_rec Soldado GasVespeno)

        (ud_necesita_ed VCE CentroDeMando)
        (ud_necesita_ed Marine Barracones)
        (ud_necesita_ed Soldado Barracones)

        (en Minerales LOC22)
        (en Minerales LOC32)

        (construido CentrodeMando1 LOC11)

        (en GasVespeno LOC44)
        
        (necesita Extractor Minerales)
        (necesita Barracones Minerales)
        (necesita Barracones GasVespeno)
        
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
        (and (construido Barracones1 LOC32)(ud_en Marine2 LOC24)(ud_en Soldado1 LOC12))
;        (and (ud_en VCE2 LOC11))
    )
)