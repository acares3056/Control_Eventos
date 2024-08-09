<!-- #include file="../includes/server/config.asp" -->
<!-- #include file="../includes/server/fnDB.asp" -->
<!-- #include file="../includes/server/mail.asp" -->
<!-- #include file="../includes/server/code_qr.asp" -->

<!-- #include file="../includes/server/valida_caracteres.asp" -->

<%
    On Error Resume Next

    DisableCache()

    Destino = Server.MapPath(".") & "\qrcode_image\"

'response.write Destino
'response.end

    Set connection = AbrirConnDB()
    
    Error = "N"
    MensajeError = "Has quedado registrado, pronto llegara un correo electronico de respaldo."

    Evento = analiza_input( request("eventos"), "n" )
    Tipo = analiza_input( request("tipo"), "C" )
    numero_documento = analiza_input( request("numero_documento"), "C" )
    nombre = analiza_input( request("nombre"), "c" )
    apellido = analiza_input( request("apellido"), "c" )
    direccion = analiza_input( request("direccion"), "c" )
    email = analiza_input( request("email"), "c" )
    telefono = analiza_input( request("telefono"), "c" )
    fecha_nacimiento = analiza_input( request("fecha_nacimiento"), "f" )
    nacionalidad = analiza_input( request("nacionalidad"), "c" )
    sexo = analiza_input( request("sexo"), "c" )
    Pais = analiza_input( request("pais"), "C" )
    ciudad = analiza_input( request("ciudad"), "c" )

    DatoCodeQR = ""

    SL = "<br>"

    sql = "Exec REGISTRO_Graba_registro " & Evento & ", " & tipo & "," & numero_documento & "," & nombre & "," & apellido & "," & direccion & "," & email & ","
    sql = sql & telefono & "," & fecha_nacimiento & "," & nacionalidad & "," & sexo & "," & pais & "," & ciudad 
    set rsReg = connection.Execute(sql)
    if connection.errors.count > 0 then 
        Error = "S"
        MensajeError = Err.Description 
    else
        if Not rsReg.Eof then
            idReg = rsReg("Id_Reg")
            DatoCodeQR = rsReg("QR_Code")
            Nombre_evento = rsReg("Nombre_evento")
        end if
    end if
    rsReg.Close()

'response.clear
'response.write DatoCodeQR & " **** "
'response.end


    'Si retorna Datos para el QRCODE imagen envia el correo
    if len(trim(DatoCodeQR)) > 0 then 
        Dim qrCodePath
        qrCodePath = GenerateQRCode( DatoCodeQR, Destino )

        aTo = request("email")
        Subject = "Inscripcion confirmada a evento " & Nombre_evento & SL & SL
        TextBody = "Gracias por inscribirte a evento " & Nombre_evento & SL
        TextBody = TextBody & "Con el siguiente codigo QR podras retirar los accesorios."
        Files = qrCodePath
        aFrom = "registro@scanid.cl"

        Call Enviar_correo(aTo, Subject, TextBody, aFrom, Files  )
    else
        aTo = "inscripcion@scanid.cl"
        Subject = "Inscripcion a ser confirmada a evento " & Nombre_evento

        TextBody = "Hubo un problema con la inscripcion: " & vbCrLf
        TextBody = TextBody & "Evento = "           & request("Evento") & vbCrLf
        TextBody = TextBody & "Tipo = "             & request("Tipo") & vbCrLf
        TextBody = TextBody & "numero_documento = " & request("numero_documento") & vbCrLf
        TextBody = TextBody & "nombre = "           & request("nombre") & vbCrLf
        TextBody = TextBody & "apellido = "         & request("apellido") & vbCrLf
        TextBody = TextBody & "direccion = "        & request("direccion") & vbCrLf
        TextBody = TextBody & "email = "            & request("email") & vbCrLf
        TextBody = TextBody & "telefono = "         & request("telefono") & vbCrLf
        TextBody = TextBody & "fecha_nacimiento = " & request("fecha_nacimiento") & vbCrLf
        TextBody = TextBody & "sexo = "             & request("sexo") & vbCrLf
        TextBody = TextBody & "Pais = "             & request("Pais") & vbCrLf
        TextBody = TextBody & "ciudad = "           & request("ciudad") & vbCrLf

        Files = ""
        aFrom = "contacto@scanid.cl"

        Call Enviar_correo(aTo, Subject, TextBody, aFrom, Files  )
    end if

    connection.Close

    MensajeError = clearError( MensajeError )


response.clear
Response.Charset = "UTF-8"
Response.ContentType = "text/html"
response.write Error & "@" & MensajeError
response.end
%>
