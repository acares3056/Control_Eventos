<%


Function analiza_input( dato, tipo)
    tipo = ucase(tipo)

    if len(trim(dato)) = 0 then 
      dato = "Null" 
    else
      if tipo = "C" then 'caracteres
        dato = "'" & dato & "'"
      elseif tipo = "N" then 'numeros
        dato = cdbl(dato)
      elseif tipo = "F" then 'fechas
        dato = "'" & year(dato) & "/" & right("00" & month(dato), 2) & "/" & right("00" & day(dato), 2) & "'"
      end if
    end if 

    analiza_input = dato
    
End Function
    
%>
