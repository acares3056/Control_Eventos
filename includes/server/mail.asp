<%

  CONST SMTPSendUsing = 2 ' Send using Port (SMTP over the network)
  CONST SMTPServer = "scanid.cl"
  CONST SMTPServerPort = 465
  CONST SMTPConnectionTimeout = 10 'seconds
  CONST SMTPUser = "contacto@scanid.cl"
  CONST SMTPPassword = "-.Contacto2024.-"


Function Enviar_correo( Para, Asunto, Cuerpo, Desde, Archivo )

  dim sSubject, sEmail, sMailBody, sFrom, sReadReceipt, sMsg
  sSubject = Asunto
  sEmail = Para
  sMailBody = Cuerpo
  sFrom = Desde
  sReadReceipt = true
  sMsg = ""

  'On Error Resume Next

  dim oMail, oConfig, oConfigFields
  set oMail = Server.CreateObject("CDO.Message")
  set oConfig = Server.CreateObject("CDO.Configuration")
  set oConfigFields = oConfig.Fields

  with oConfigFields
      .Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = SMTPSendUsing
      .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = SMTPServer
      .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = SMTPServerPort
      .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
      .Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = SMTPUser
      .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = SMTPPassword
      .Item("http://schemas.microsoft.com/cdo/configuration/sendtls") = True
      .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True
      .Update
  end with

  oMail.Configuration = oConfig

  oMail.Subject = sSubject
  oMail.From = sFrom
  oMail.To = sEmail
  oMail.HTMLBody = sMailBody

  if len(trim(Archivo)) > 0 then 
    oMail.AddAttachment Archivo
  end if

  oMail.Send
  set oMail=nothing

  sMsg = "Message Sent"

  if Err.Number > 0 then sMsg = "ERROR: " & Err.Description

  Enviar_correo = sMsg
  
End Function

 


%>