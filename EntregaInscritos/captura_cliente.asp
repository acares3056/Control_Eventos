<!-- #include file="../includes/server/config.asp" -->
<!-- #include file="../includes/server/fnDB.asp" -->
<%

  if len(trim(Session("scanid_Login"))) = 0 then 
    response.Redirect ( "default.asp")
  end if 

  if len(trim(Session("metodo_captura"))) = 0 then 
    Session("metodo_captura") = "captura"
  elseif Session("metodo_captura") <> "captura" then
    response.Redirect ( "metodo_captura.asp?rnd=" & now() )
    response.end
  end if

%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Formulario Entrega Accesorios</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<%
'On Error Resume Next

DisableCache()

    Response.Write("<form id='frmEntrega' name='frmEntrega' method='post'>")

    Response.Write("<table class='table table-hover' width='50%' ><thead>")
    Response.Write("<tr>")
    Response.Write("<h1 class='mb-4 text-center'>Entrega de Accesorios</h2>")
    Response.Write("</tr>")
    Response.Write("</thead></table>")

    Response.Write("<input type='hidden' name='id' value='" & id & "'>")
    Response.Write("<input type='hidden' name='codigo_qr' id='codigo_qr' value='' size='30' style='border:1px solid black;'>")

    Response.Write("</tbody></table>")

        Response.Write("<table width='100%' >")
        Response.Write("<tr>")
        Response.Write("<td class='fw-bold text-center'>Acerque el codigo QR</td>")
        Response.Write("</tr>")
        Response.Write("<tr>")
        Response.Write("<td align='center' width='50%'>") 
%>
        <!-- #include file="captura.html" -->
<%
        Response.Write("</td>")
        Response.Write("</tr>")
        Response.Write("</table>")
    
    Response.Write("</form>")

' Limpiar y cerrar recursos
%>

<!-- Archivos JavaScript de Bootstrap y jQuery (necesarios para AJAX) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<form id="frmQRCODE" id="frmQRCODE" method="POST" action="detalle_cliente.asp" target="_top">
  <input type="hidden" id="qr_code" name="qr_code" value="">
</form>

<script>


    function fnConsultaQRCode() {
        //var qrcode = document.frmEntrega.codigo_qr.value;  
//alert ( qrcode);
        //document.frmQRCODE.qr_code.value = qrcode;
        document.frmEntrega.action = "detalle_cliente.asp"
        document.frmEntrega.submit();
        //parent.top.location.href = 'detalle_cliente.asp?qr_code=' + qr_code;
        
    }

    function fnVolver(){
        parent.top.location.href = "metodo_captura.asp?rnd=" + Math.random();
    }

</script>
