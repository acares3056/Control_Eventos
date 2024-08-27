<!-- #include file="../../includes/server/config.asp" -->
<!-- #include file="../../includes/server/fnDB.asp" -->

<%
'On Error Resume Next

  if len(trim(Session("scanid_Login"))) = 0 then 
    'response.Redirect ( "default.asp")
  end if 

DisableCache()

txtMensaje = ""
txtError = "N"

Set objConn = AbrirConnDB()

' Recibir datos del formulario
Dim nombre, apellidos, direccion
nombre    = Sanitize(Request("nombre"))

' Construir la consulta SQL
strQuery = "Execute EVENTOS_Lista_eventos '" & nombre & "'"
'response.write strQuery
Set objRs = objConn.Execute(strQuery)

' Mostrar resultados
If objRs.EOF Then
    response.clear
    Response.Write("<p>No se encontraron resultados.</p>")
Else
    Response.Write("<table id='tablaClientes' class='table order-column cell-border row-border hover display nowrap' width='100%' cellspacing='0'><thead><tr>")
    
    Response.Write("<th>Codigo</th>")
    Response.Write("<th>Descripcion</th>")
    Response.Write("<th>Estado</th>")

    Response.Write("</tr></thead><tbody>")

    Do While Not objRs.EOF
        Id_Evento        = objRs("Id_Evento")
        Codigo       = objRs("Codigo")
        Descripcion    = objRs("Descripcion")
        Estado = objRs("Estado")
		
		estilolinea = ""
		if Estado <> "A" then
			estilolinea = " style='background-color: yellow; color: black;' "
		end if 

        Response.Write("<tr " & estilolinea & " onclick='javascript:fnEntrega(" & Id_Evento & ")'>")
        
        Response.Write("<td>" & Codigo         & "</td>")
        Response.Write("<td>" & Descripcion      & "</td>")
        Response.Write("<td>" & Estado   & "</td>")

        Response.Write("</tr>")

        objRs.MoveNext
    Loop
    Response.Write("</tbody></table>")
End If
' Limpiar y cerrar recursos
objRs.Close
Set objRs = Nothing

objConn.Close
Set objConn = Nothing

%>