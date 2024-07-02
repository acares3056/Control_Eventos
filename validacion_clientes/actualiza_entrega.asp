<!-- #include file="../includes/server/config.asp" -->
<!-- #include file="../includes/server/fnDB.asp" -->

<%
On Error Resume Next

  if len(trim(Session("scanid_Login"))) = 0 then 
    response.Redirect ( "default.asp")
  end if 

DisableCache()

txtMensaje = "Proceso realizado"
txtError = "N"

Set objConn = AbrirConnDB()

id        = Sanitize( request("id") )
codigo_qr = Sanitize( request("codigo_qr") )

' Construir la consulta SQL
strQuery = "Execute CLIENTES_actualiza_codigo_qr " & id & ", '" & codigo_qr & "'"
objConn.Execute(strQuery)
if objConn.Errors.Count > 0 then 
    txtMensaje = Err.Description
    txtError = "S"
end if
objConn.Close
Set objConn = Nothing

txtMensaje = cleanError(txtMensaje)

response.clear
response.write txtError & "@" & txtMensaje
response.end
%>