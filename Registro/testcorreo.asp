<!-- #include file="../includes/server/mail.asp" -->

<%


Envio = Enviar_correo( "alejandro.cares@gmail.com", "Inscripcion Exitosa", "Gracias por inscribirte", "registro@scanid.cl", "C:\inetpub\wwwroot\Control_Eventos\Registro\qrcode_image\qrcode_162235.png" )


response.write Envio

%>
