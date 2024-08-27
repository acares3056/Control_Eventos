<!-- #include file="../includes/server/config.asp" -->
<!-- #include file="../includes/server/fnDB.asp" -->
<%

  if len(trim(Session("scanid_Login"))) = 0 then 
    response.Redirect ( "default.asp")
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

txtMensaje = ""
txtError = "N"

Set objConn = AbrirConnDB()

id   = Sanitize( request("id") )

' Construir la consulta SQL
strQuery = "Execute CLIENTES_Lista_clientes " & id & ", Null, Null, Null"
Set objRs = objConn.Execute(strQuery)

' Mostrar resultados
If objRs.EOF Then
    response.clear
    Response.Write("<p>No se encontraron resultados.</p>")
Else

    Response.Write("<form id='frmEntrega' name='frmEntrega' method='post'>")

    Response.Write("<table class='table table-hover' width='50%' ><thead>")
    Response.Write("<tr>")
    Response.Write("<h1 class='mb-4 text-center'>Entrega de Accesorios</h2>")
    Response.Write("</tr>")
    Response.Write("</thead></table>")

    Response.Write("<table class='table table-hover' width='50%' ><tbody>")
    
    Rut       = objRs("Rut/Dni/Pasaporte")
    nombre    = objRs("nombres")
    apellidos = objRs("apellidos")
    direccion = objRs("direccion")
    ciudad    = objRs("ciudad")
    nombre_club = objRs("nombre_de_club")
    QR_Code_Entrega_Vestimenta = objRs("QR_Code_Entrega_Vestimenta")
        if IsNull(QR_Code_Entrega_Vestimenta) then QR_Code_Entrega_Vestimenta = ""

    Response.Write("<tr>")
    Response.Write("<th>Rut/DNI/Pasaporte</th><td>" & Rut & "</td>")
    Response.Write("</tr>")

    Response.Write("<tr>")
    Response.Write("<th>Nombre</th><td>" & nombre & "</td>")
    Response.Write("</tr>")

    Response.Write("<tr>")
    Response.Write("<th>Apellidos</th><td>" & apellidos & "</td>")
    Response.Write("</tr>")

    Response.Write("<tr>")
    Response.Write("<th>Direcci&oacute;n</th><td>" & direccion & "</td>")
    Response.Write("</tr>")

    Response.Write("<tr>")
    Response.Write("<th>Ciudad</th><td>" & ciudad & "</td>")
    Response.Write("</tr>")

    Response.Write("<tr>")
    Response.Write("<th>Club</th><td>" & nombre_club )
    Response.Write("<input type='hidden' name='id' value='" & id & "'>")
    Response.Write("<input type='hidden' name='codigo_qr' id='codigo_qr' value='' size='30' style='border:1px solid black;'>")
    Response.Write("</td>" )
    Response.Write("</tr>")

    Response.Write("</tbody></table>")

    if len(trim(QR_Code_Entrega_Vestimenta)) = 0 then
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
    else
        Response.Write("<h2 class='p-3 mb-2 bg-success  text-white'>")
        Response.Write("Ya se encuentra con entrega realizada ")
        Response.Write("</h2>")

        Response.Write("<div class='d-grid gap-2 text-center'>")
        Response.Write("<button type='button' class='btn btn-primary btn-lg' onclick='javascript:fnVolver();'>Aceptar</button>")
        Response.Write("</div>")

    end if
    Response.Write("</form>")

End If
' Limpiar y cerrar recursos
objRs.Close
Set objRs = Nothing

objConn.Close
Set objConn = Nothing
%>



<!-- Archivos JavaScript de Bootstrap y jQuery (necesarios para AJAX) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>

    function fnGrabarQRCode() {
        var txtResp = "";
        var imageIcon = "";

// alert ( 'Grabando codigo:' + document.all("codigo_qr").value );
// return;

        $.ajax({
            url: 'actualiza_entrega.asp',
            type: 'POST',
            data: $("#frmEntrega").serialize(),
            success: function( data ) {
                var aData = data.split('@');
                var xError = aData[0];
                    txtResp = aData[1];

                if ( xError =='N' ) {
                    imageIcon = "success";
                }else{
                    imageIcon = "error";
                }

                Swal.fire({
                  title: txtResp,
                  text: "",
                  icon: imageIcon,
                  backdrop: 'swal2-backdrop-show',
                  allowOutsideClick: false,
                  allowEscapeKey: false,
                  allowEnterKey: false,
                  confirmButtonText: 'Aceptar'
                }).then((result) => {
                  /* Read more about isConfirmed, isDenied below */
                  if (result.isConfirmed) {
                    fnVolver();
                  }
                });
            },
            error: function(xhr, status, error) {
                // Manejar errores
                txtResp = status + ' - ' + error;
                imageIcon = "error";
                console.error(status, error);
                Swal.fire({
                  title: 'Error!',
                  text: txtResp,
                  icon: imageIcon,
                  confirmButtonText: 'Entendido'
                });
            }
        });
    }

    function fnVolver(){
        parent.top.location.href = "index.asp?rnd=" + Math.random();
    }

</script>
