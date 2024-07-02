<%

Const cdoSendUsingPickup = 1
Const cdoSendUsingPort = 2
Const cdoSendUsingExchange = 3

Const cdoAnonymous = 0
Const cdoBasic = 1
Const cdoNTLM = 2

'Sends an email To aTo email address, with Subject And TextBody.
'The email is In text format.
'Lets you specify BCC adresses, Attachments, smtp server And Sender email address
Function SendMailByCDO(aTo, Subject, TextBody, BCC, Files, smtp, aFrom )
  on error resume Next

  Dim Message 'As New CDO.Message '(New - For VBA)
  
  'Create CDO message object
  Set Message = CreateObject("CDO.Message")

  'Set configuration fields. 
  With Message.Configuration.Fields
    'Original sender email address 
    .Item("http://schemas.microsoft.com/cdo/configuration/sendemailaddress") = aFrom

    'SMTP settings - without authentication, using standard port 25 on host smtp
    .Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = cdoSendUsingPort
    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = smtp

    .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = cdoBasic
    .Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "contacto@scanid.cl"
    .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "-.Contacto2024.-"
    '.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True/False

    'SMTP Authentication
    .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = cdoAnonymous

    .Update
  End With

  'Set other message fields.
  With Message
    'From, To, Subject And Body are required.
    .From = aFrom
    .To = aTo
    .Subject = Subject

    'Set TextBody property If you want To send the email As plain text
    .TextBody = TextBody

    'Set HTMLBody  property If you want To send the email As an HTML formatted
    '.HTMLBody = TextBody

    'Blind copy And attachments are optional.
    If Len(BCC)>0 Then .BCC = BCC
    If Len(Files)>0 Then .AddAttachment Files
    
    'Send the email
    .Send
  End With

  'Returns zero If succesfull. Error code otherwise 
  SendMailByCDO = Err.Number
End Function

%>