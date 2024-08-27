<!-- #include file="../includes/server/config.asp" -->
<!-- #include file="../includes/server/fnDB.asp" -->
<%
  On Error Resume Next

  DisableCache()

  if len(trim(Session("scanid_Login"))) = 0 then 
    response.Redirect ( "default.asp")
  end if 

  if len(trim(Session("metodo_captura"))) = 0 then 
    Session("metodo_captura") = "lectura"
  elseif Session("metodo_captura") <> "lectura" then
    response.Redirect ( "metodo_captura.asp?rnd=" & now() )
    response.end
  end if

%>
  <!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lectura de Código QR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- SweetAlert2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            background-color: #007bff;
            color: #fff;
            border-bottom: 1px solid #e9ecef;
        }
        .form-control {
            border-radius: 5px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header text-center">
                    <h5>Entrega de Accesorios - Lectura de Código QR</h5>
                </div>
                <div class="card-body">
                    <p class="text-center mb-4">Utiliza el siguiente campo para capturar el código QR. Tu escáner debería rellenar automáticamente el campo a medida que el código es escaneado.</p>
                    <form id='frmEntrega' name='frmEntrega' method='post'  >
                        <div class="mb-3">
                            <label for="codigo_qr" class="form-label">Código QR</label>
                            <input type="text" class="form-control" id="codigo_qr" name="codigo_qr" placeholder="Escanea el código QR aquí" autofocus autocomplete='off'>
                        </div>
                        <div class="text-center">
                            <button type="button" class="btn btn-primary" onclick="javascript:fnConsultaQRCode()">Consultar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

 
<!-- Archivos JavaScript de Bootstrap y jQuery (necesarios para AJAX) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>

    let timeout;
    const input = document.getElementById('codigo_qr');

    input.addEventListener('input', () => {
        clearTimeout(timeout);
        timeout = setTimeout(() => {
            fnConsultaQRCode();
        }, 1000); // Espera de 1 segundo
    });


    function fnConsultaQRCode() {
        var codigo_qr = document.getElementById('codigo_qr').value;

        if ( codigo_qr.trim().length === 0) {
            Swal.fire({
                      title: 'Advertencia!',
                      text: "No ha scaneado ningun el código QR.",
                      icon: "error",
                      confirmButtonText: 'Aceptar'
                    });   
            return;
        }

          $.ajax({
                url: "detalle_cliente.asp?soloconsulta=S&codigo_qr=" + codigo_qr + "&rnd=" + Math.random(),
                method: "GET",
                success: function ( data ) {
                    var aData = data.split(";");

                    if ( aData[0] == "N") {
                      document.frmEntrega.action = "detalle_cliente.asp";
                      document.frmEntrega.submit();
                    } else {
                        Swal.fire({
                          title: 'Advertencia!',
                          text: aData[1],
                          icon: "error",
                          confirmButtonText: 'Entendido'
                        });                
                    }
                },
                error: function () {
                    Swal.fire({
                      title: 'Advertencia!',
                      text: "Error al procesar la solicitud. Por favor, inténtalo de nuevo más tarde.",
                      icon: "error",
                      confirmButtonText: 'Entendido'
                    });                
                }
            });      
    }

    function fnVolver(){
        parent.top.location.href = "metodo_captura.asp?rnd=" + Math.random();
    }

</script>

</body>
</html>
