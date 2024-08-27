<!-- #include file="../includes/server/config.asp" -->
<!-- #include file="../includes/server/fnDB.asp" -->

<%
On Error Resume Next

  if len(trim(Session("scanid_Login"))) = 0 then 
    response.Redirect ( "default.asp")
  end if 

DisableCache()

txtMensaje = ""
txtError = "N"
cboEventos = ""

Set objConn = AbrirConnDB()

' Construir la consulta SQL
strQuery = "Execute EVENTOS_Lista_eventos Null"
'response.write strQuery
Set objRs = objConn.Execute(strQuery)

' Mostrar resultados
If objRs.EOF Then
    response.clear
    Response.Write("<p>No hay eventos para seleccionar, consulte con el Administrador de eventos.</p>")
Else    
    Do While Not objRs.EOF
        cboEventos = cboEventos & "<option value='" & objRs("Codigo") & "'>" & objRs("Descripcion") & "</option>" & VbCrLF
        objRs.MoveNext
    Loop    
End If
' Limpiar y cerrar recursos
objRs.Close
Set objRs = Nothing

objConn.Close
Set objConn = Nothing

%>


<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Selección de Evento</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
        }
        .form-select:required:invalid {
            color: gray;
        }
        .form-select option[value=""][disabled] {
            display: none;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header text-center">
                    <h4>Selecciona un Evento</h4>
                </div>
                <div class="card-body">
                    <form id="evento-form">
                        <div class="mb-3">
                            <label for="cboEventos" class="form-label">Evento</label>
                            <select class="form-select" id="cboEventos" required>
                                <option value="" selected disabled>Selecciona un evento</option>
                                
                                <% response.write(cboEventos) %>

                            </select>
                            <div class="invalid-feedback">
                                Por favor, selecciona un evento.
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Aceptar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    // Example starter JavaScript for disabling form submissions if there are invalid fields
    $("#evento-form").submit(function (e) {
        e.preventDefault();
        const cboEvento = $("#cboEventos").val();
        
        if ( cboEvento == '' ) {                
            Swal.fire({
              title: 'Advertencia!',
              text: "Debes seleccionar un evento para continuar.",
              icon: "error",
              confirmButtonText: 'Entendido'
            });
            return false;
        }
        else
        {
            location.replace('index.asp');
        }

    })
</script>

</body>
</html>
