<!-- #include file="../includes/server/config.asp" -->
<!-- #include file="../includes/server/fnDB.asp" -->
<%
''    On Error Resume Next

    DisableCache()

    txtMensaje = ""
    txtError = "N"


    cboCiudad = "<select class='form-control' id='tipo' name='tipo' required><option value=''></option></select>"


%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulario de Inscripción</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #007bff;
        }
        .nav-tabs .nav-link.active {
            background-color: #007bff;
            color: white;
        }

        .contenedor-personalida{
            background-color: #f0f0f0;
            border-radius: 20px;
            padding: 20px;
            margin: 20px auto; 
        }
    </style>
</head>
<body>
    <div class="container mt-5 contenedor-personalida">
        <div class="card">
            <div class="card-header">
                <h4>Formulario de Inscripción</h4>
            </div>
            <div class="card-body">
                <ul class="nav nav-tabs" id="myTab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" id="info-personal-tab" data-toggle="tab" href="#info-personal" role="tab" aria-controls="info-personal" aria-selected="true">Información Personal</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="cualidades-fisicas-tab" data-toggle="tab" href="#cualidades-fisicas" role="tab" aria-controls="cualidades-fisicas" aria-selected="false">Cualidades Físicas</a>
                    </li>
                </ul>
                <div class="tab-content" id="myTabContent">
                    <!-- Información Personal -->
                    <div class="tab-pane fade show active" id="info-personal" role="tabpanel" aria-labelledby="info-personal-tab">
                        <form method="post" action="procesar_formulario.asp">
                            <div class="row justify-content-start">
                                <div class="form-group mt-3 col-6">
                                    <label for="tipo">Tipo:</label>
                                    <select class="form-control" id="tipo" name="tipo" required>
                                        <option value="C">Cedula Nacional</option>
                                        <option value="P">Pasaporte</option>
                                    </select>
                                </div>
                                <div class="form-group mt-3 col-6">
                                    <label for="numero_documento">Nro. documento:</label>
                                    <input type="text" class="form-control" id="numero_documento" name="numero_documento" size='8' maxlength='8' required>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <label for="nombre">Nombres:</label>
                                    <input type="text" class="form-control" id="nombre" name="nombre" size='50' maxlength='50' required>
                                </div>
                                <div class="col-md-6">
                                    <label for="apellido">Apellidos:</label>
                                    <input type="text" class="form-control" id="apellido" name="apellido" size='50' maxlength='50' required>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="direccion">Direccion:</label>
                                <input type="text" class="form-control" id="direccion" name="direccion" size='100' maxlength='100' required>
                            </div>
                            <div class="form-group">
                                <label for="email">Correo Electrónico:</label>
                                <input type="email" class="form-control" id="email" name="email" size='50' maxlength='50' required>
                            </div>
                            <div class="form-group">
                                <label for="telefono">Teléfono:</label>
                                <input type="tel" class="form-control" id="telefono" name="telefono" required>
                            </div>
                            <div class="form-group">
                                <label for="fecha_nacimiento">Fecha nacimiento:</label>
                                <input type="tel" class="form-control" id="fecha_nacimiento" name="fecha_nacimiento" required>
                            </div>
                            <div class="form-group mt-3">
                                <label for="pais">Pais:</label>
                                <select class="form-control" id="pais" name="pais" required>
                                    <% response.write ( cboPais ) %>
                                </select>
                            </div>
                            <div class="form-group mt-3">
                                <label for="ciudad">Ciudad:</label>
                                    <% response.write ( cboCiudad ) %>
                            </div>
                        </form>
                    </div>
                    <!-- Cualidades Físicas -->
                    <div class="tab-pane fade" id="cualidades-fisicas" role="tabpanel" aria-labelledby="cualidades-fisicas-tab">
                        <form method="post" action="procesar_formulario.asp">
                            <div class="form-group mt-3">
                                <label for="altura">Altura:</label>
                                <input type="text" class="form-control" id="altura" name="altura" required>
                            </div>
                           
                        </form>
                    </div>
                </div>
                <!-- Botón de Envío -->
                <button type="submit" class="btn btn-primary mt-3">Registrarse</button>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
    </html>
        