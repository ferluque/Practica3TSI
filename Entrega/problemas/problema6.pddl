(define (problem Ejercicio6)
    (:domain StarcraftDom6)
    (:objects 
        LOC11,LOC12,LOC13,LOC14,LOC21,LOC22,LOC23,LOC24,LOC31,LOC32,LOC33,LOC34,LOC44 - loc
        VCE1, VCE2, VCE3 - unidad
        Extractor1 - edificio
        Barracones1 CentroDeMando1 BahiaIngenieria1 - edificio
        Marine1 Marine2 Soldado1 - unidad
    )
    (:init
        (tipo_ed BahiaIngenieria1 BahiaIngenieria)
        (necesita BahiaIngenieria Minerales)
        (necesita BahiaIngenieria GasVespeno)

        (inv_necesita InvSoldadoUniversal Minerales)
        (inv_necesita InvSoldadoUniversal GasVespeno)

        (tipo Marine1 Marine)
        (tipo Marine2 Marine)
        (tipo Soldado1 Soldado)

        (reclutado_en Marine Barracones)
        (reclutado_en Soldado Barracones)

        (ud_necesita_rec Marine Minerales)
        (ud_necesita_rec Soldado Minerales)
        (ud_necesita_rec Soldado GasVespeno)
        (ud_necesita_rec VCE Minerales)

        (reclutado_en VCE CentroDeMando)

        (tipo_ed CentroDeMando1 CentroDeMando)
        (construido CentroDeMando1 LOC11)
        
        (tipo_ed Extractor1 Extractor)
        (tipo_ed Barracones1 Barracones)
        
        (tipo VCE1 VCE)
        (tipo VCE2 VCE)
        (tipo VCE3 VCE)

        (ud_en VCE1 LOC11)

        (en Minerales LOC22)
        (en Minerales LOC32)

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

        (= (long_plan) 0)

    )
    
    (:goal 
        (and (construido Barracones1 LOC14)(construido BahiaIngenieria1 LOC12)
        (ud_en Marine1 LOC14)(ud_en Marine2 LOC14)(ud_en Soldado1 LOC14)(<= (long_plan) 24)
                                                                            ; Se limita la longitud del plan al del último encontrado, hasta que haya una longitud
                                                                            ; Para la que no encuentre, en este caso si ponemos < 24 ya no encuentra.
        )
    )
)