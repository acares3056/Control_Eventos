<%
function Acceso_Pagina()

    acceso = true
    if len(trim(Session("scanid_Login"))) = 0 then
        acceso = false 
    end if 
    Acceso_Pagina = acceso

end function
%>