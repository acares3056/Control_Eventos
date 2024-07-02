<!-- #include file="../includes/server/config.asp" -->
<!-- #include file="../includes/server/fnDB.asp" -->
<%
    On Error Resume Next

    DisableCache()

    txtMensaje = ""
    txtError = "N"

    Set objConn = AbrirConnDB()

    usuario   = Sanitize( request("usuario") )
    seguridad = Sanitize( request("seguridad") )

    if validaEntrada( usuario ) Or validaEntrada( seguridad ) then 
        txtMensaje = "No se puede continuar existe un intento de vulnerabilidad al sistema."
        txtError = "S"
    end if

    if txtError = "N" Then 
        strQuery = "Execute USUARIOS_Valida_usuario '" & usuario & "', '" & seguridad & "'"
    
        set objRs = objConn.Execute( strQuery )
        if objConn.Errors.Count = 0 then 
            if Not objRs.Eof then 
                Session("dsb_id_Login") = objRs("usuario")
                Session("dsb_id_nombre")  = objRs("nombre")
                Session("dsb_id_apellido")  = objRs("Apellidos")
                Session("dsb_evento")       = 1
            else
                txtError = "S"
                txtMensaje = "El usuario ingresado no es valido."
            end if 
        else
            txtError = "S"
            txtMensaje = err.Description
        end if 
    end if 

    txtMensaje = Sanitize( txtMensaje)

    objRs.Close
    Set objRs = nothing    
    CerraConnDB( objConn )


    'Response.Clear

    Set responseData = Server.CreateObject("Scripting.Dictionary")
    responseData.Add "error", txtError
    responseData.Add "mensaje", txtMensaje

    ' Convertimos el diccionario a formato JSON
    Dim jsonString
    jsonString = "{"
    For Each key In responseData.Keys
        jsonString = jsonString & """" & key & """" & ": """ & responseData(key) & ""","
    Next
    ' Quitamos la coma adicional al final y cerramos el objeto JSON
    jsonString = Left(jsonString, Len(jsonString) - 1) & "}"

    Response.clear

    Response.Write jsonString

    Response.End
%>