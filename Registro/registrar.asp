<!-- #include file="../includes/server/config.asp" -->
<!-- #include file="../includes/server/fnDB.asp" -->
<%
    DisableCache()
    Set connection = AbrirConnDB()
    Error = "N"
    MensajeError = ""

if false then 
    Pais = request("pais")
        if len(trim(Pais)) = 0 then Pais = "Null" else Pais = "'" & Pais & "'"

    sql = "Exec REGISTRO_Graba_ciudades " & Pais
    Set rs = connection.Execute(sql)

    rs.Close
end if
    connection.Close

response.clear
Response.Charset = "UTF-8"
Response.ContentType = "text/html"
response.write Error & "@" & MensajeError
response.end
%>
