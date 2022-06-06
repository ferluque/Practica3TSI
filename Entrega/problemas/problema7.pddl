(define (problem Ejercicio7)
    (:domain StarcraftDom7)
    (:objects 
        LOC11,LOC12,LOC13,LOC14,LOC21,LOC22,LOC23,LOC24,LOC31,LOC32,LOC33,LOC34,LOC44 - loc
        VCE1, VCE2, VCE3 - unidad
        Extractor1 - edificio
        Barracones1 CentroDeMando1 - edificio
        Marine1 Marine2 Soldado1 - unidad
    )
    (:init
        ; Ejercicio 7
        ; Se inicializa la longitud
        (= (long_plan) 0)

        ; Se inicializan los tanques vacíos
        (= (cantidad Minerales) 0)
        (= (cantidad GasVespeno) 0)

        ; No hay VCEs asignados
        (= (asignados Minerales LOC22) 0)
        (= (asignados Minerales LOC32) 0)

        (en GasVespeno LOC44)
        (= (asignados GasVespeno LOC44) 0)
        
        ; Las cantidades requeridas para reclutar y construir
        (necesita Barracones Minerales)
        (necesita Barracones GasVespeno)
        (= (ed_necesita_tantos Barracones Minerales) 30)
        (= (ed_necesita_tantos Barracones GasVespeno) 10)

        (necesita Extractor Minerales)
        (= (ed_necesita_tantos Extractor Minerales) 10)
        (= (ed_necesita_tantos Extractor GasVespeno) 0)

        (ud_necesita_rec VCE Minerales)
        (= (ud_necesita_tantos VCE Minerales) 5)

        (ud_necesita_rec Marine Minerales)
        (ud_necesita_rec Marine GasVespeno)
        (= (ud_necesita_tantos Marine Minerales) 10)
        (= (ud_necesita_tantos Marine GasVespeno) 15)

        (ud_necesita_rec Soldado Minerales)
        (ud_necesita_rec Soldado GasVespeno)
        (= (ud_necesita_tantos Soldado Minerales) 30)
        (= (ud_necesita_tantos Soldado GasVespeno) 30)
        ;;

        ; Mapa
        (en Minerales LOC22)
        (en Minerales LOC32)
        (tipo Marine1 Marine)
        (tipo Marine2 Marine)
        (tipo Soldado1 Soldado)

        (reclutado_en Marine Barracones)
        (reclutado_en Soldado Barracones)
        (reclutado_en VCE CentroDeMando)

        (tipo_ed CentroDeMando1 CentroDeMando)
        (construido CentroDeMando1 LOC11)
        (ya_construido CentroDeMando1)
        
        (tipo_ed Extractor1 Extractor)
        (tipo_ed Barracones1 Barracones)
        
        (tipo VCE1 VCE)
        (tipo VCE2 VCE)
        (tipo VCE3 VCE)

        (ud_en VCE1 LOC11)
        (ya_reclutado VCE1)
        
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
        (and (construido Barracones1 LOC32)(ud_en Soldado1 LOC12)(ud_en Marine1 LOC31)(ud_en Marine2 LOC24)(<=(long_plan)56))
    )
)

;(ud_en Marine1 LOC31)(ud_en Marine2 LOC24)(ud_en Soldado1 LOC12)