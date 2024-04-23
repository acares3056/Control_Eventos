<!-- #include file="../includes/server/config.asp" -->
<!-- #include file="../includes/server/fnDB.asp" -->

<%
'On Error Resume Next

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
Set objRs = objConn.Execute(strQuery)

' Mostrar resultados
If objRs.EOF Then
    Response.Write("<p>No se encontraron resultados.</p>")
Else
    Response.Write("<table id='tablaClientes' class='table order-column cell-border row-border' ><thead><tr><th>Nombre</th><th>Apellidos</th><th>Direcci&oacute;n</th></tr></thead><tbody>")
    Do While Not objRs.EOF
        nombre    = objRs("nombres")
        apellidos = objRs("apellidos")
        direccion = objRs("direccion")

        Response.Write("<tr><td>" & nombre & "</td><td>" & apellidos & "</td><td>" & direccion & "</td></tr>")

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