<!-- #include file="../includes/server/config.asp" -->
<!-- #include file="../includes/server/fnDB.asp" -->

<%
On Error Resume Next

  if len(trim(Session("scanid_Login"))) = 0 then 
    response.Redirect ( "default.asp")
  end if 

DisableCache()

txtMensaje = ""
txtError = "N"

Set objConn = AbrirConnDB()

usuario   = Sanitize( request("usuario") )
seguridad = Sanitize( request("seguridad") )

' Recibir datos del formulario
Dim nombre, apellidos, direccion
nombre    = Sanitize(Request("nombre"))
apellidos = Sanitize(Request("apellidos"))
direccion = Sanitize(Request("direccion"))

' Construir la consulta SQL
strQuery = "Execute CLIENTES_Lista_clientes Null, '" & nombre & "', '" & apellidos & "', '" & direccion & "'"
'response.write strQuery
Set objRs = objConn.Execute(strQuery)

' Mostrar resultados
If objRs.EOF Then
    response.clear
    Response.Write("<p>No se encontraron resultados.</p>")
Else
    Response.Write("<table id='tablaClientes' class='table order-column cell-border row-border hover display nowrap' width='100%' cellspacing='0'><thead><tr>")
    
    Response.Write("<th>Rut/DNI/Pasaporte</th>")
    Response.Write("<th>Nombre</th>")
    Response.Write("<th>Apellidos</th>")
    Response.Write("<th>Direcci&oacute;n</th>")
    Response.Write("<th>Ciudad</th>")
    Response.Write("<th>Club</th>")

    Response.Write("</tr></thead><tbody>")

    Do While Not objRs.EOF
        Id        = objRs("ID")
        Rut       = objRs("Rut/Dni/Pasaporte")
        nombre    = objRs("nombres")
        apellidos = objRs("apellidos")
        direccion = objRs("direccion")
        ciudad    = objRs("ciudad")
        nombre_club = objRs("nombre_de_club")
		
		QR_Code_Entrega_Vestimenta = objRs("QR_Code_Entrega_Vestimenta")
        	if IsNull(QR_Code_Entrega_Vestimenta) then QR_Code_Entrega_Vestimenta = ""

		estilolinea = ""
		if QR_Code_Entrega_Vestimenta <> "" then
			estilolinea = " style='background-color: green; color: white;' "
		end if 

        Response.Write("<tr " & estilolinea & " onclick='javascript:fnEntrega(" & Id & ")'>")
        
        Response.Write("<td>" & Rut         & "</td>")
        Response.Write("<td>" & nombre      & "</td>")
        Response.Write("<td>" & apellidos   & "</td>")
        Response.Write("<td>" & direccion   & "</td>")
        Response.Write("<td>" & ciudad      & "</td>")
        Response.Write("<td>" & nombre_club & "</td>")

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