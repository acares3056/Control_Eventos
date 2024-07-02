<!-- #include file="../includes/server/config.asp" -->
<!-- #include file="../includes/server/fnDB.asp" -->
<%

Set Conn = AbrirConnDB()
Set rs = Conn.Execute("SELECT * FROM Clientes")

' Generar código HTML del formulario
Dim strForm  
strForm = "<form method='post' action='procesar_formulario.asp'>"

for i = 0 to rs.fields.Count - 1    

    Dim strCampo  
    Dim strTipoCampo 
    Dim strLongitudCampo 

    strCampo = rs.fields(i).name
    strTipoCampo = rs.fields(i).type
    strLongitudCampo = rs.fields(i).length

Response.write strCampo & " --- " & strTipoCampo & " ---- " & strLongitudCampo & "<br>"

    Select Case strTipoCampo
        Case "varchar", "nvarchar":
            strForm = strForm & "<label for=" & strCampo & ">:" & "</label>" & _
                            "<input type='text' name=" & strCampo & " id=" & strCampo & " size=" & strLongitudCampo & ">" & _
                            "<br>"
        Case "int", "decimal", "smallint":
            strForm = strForm & "<label for=" & strCampo & ">:" & "</label>" & _
                            "<input type='text' name=" & strCampo & " id=" & strCampo & " size=" & strLongitudCampo & ">" & _
                            "<br>"
        Case "bit":
            strForm = strForm & "<label for=" & strCampo & ">:" & "</label>" & _
                            "<input type='checkbox' name=" & strCampo & " id=" & strCampo & ">" & _
                            "<br>"
        ' ... Otros tipos de campo
    End Select

    'rs.MoveNext
next

strForm = strForm & "<input type='submit' value='Enviar'>" & _
                    "<input type='reset' value='Reiniciar'>" & _
                    "</form>"

Response.Write strForm

' Cerrar conexión a la base de datos
rs.Close
Set rs = Nothing
conn.Close
Set conn = Nothing

%>