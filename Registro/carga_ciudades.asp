<!-- #include file="../includes/server/config.asp" -->
<!-- #include file="../includes/server/fnDB.asp" -->

<%

    DisableCache()

    Set connection = AbrirConnDB()

    Pais = request("pais")
        if len(trim(Pais)) = 0 then Pais = "Null" else Pais = "'" & Pais & "'"

    sql = "Exec PAISES_lista_ciudades " & Pais
    Set rs = connection.Execute(sql)

    cboCiudad = "<select class='form-control' id='cboCiudad' name='cboCiudad' required>" & VbCrLf
    cboCiudad = cboCiudad & "<option value=''>Seleccione la ciudad</option>" & VbCrlf
    Do While Not rs.eof
        cboCiudad = cboCiudad & "<option value='" & Trim(rs("codigo")) & "'>" & Server.HTMLEncode( Trim(rs("nombre")) ) & "</option>" & VbCrLF
        rs.MoveNext
    Loop
    cboCiudad = cboCiudad & "</select>" & VbCrLf 

    rs.Close
    connection.Close

response.clear

Response.Charset = "UTF-8"
Response.ContentType = "text/html"

response.write cboCiudad
response.end
%>
