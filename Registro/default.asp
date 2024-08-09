<!-- #include file="../includes/server/config.asp" -->
<!-- #include file="../includes/server/fnDB.asp" -->
<%
''    On Error Resume Next

    DisableCache()

    txtMensaje = ""
    txtError = "N"

    Set objConn = AbrirConnDB()

    strQry = "Exec PAISES_Lista_paises null, null"
    set objRs = objConn.Execute( strQry )
    cboPais = "<option value=''>Seleccione un pais</option>"
    if Not objRs.Eof then
        Do While Not objRs.Eof
            cboPais = cboPais & "<option value='" & objRs("PaisCodigo") & "'>" & objRs("PaisNombre") & "</option>"
            objRs.MoveNext
        Loop
    end if
    objRs.Close

    strQry = "Exec EVENTOS_Lista_eventos null"
    set objRs = objConn.Execute( strQry )
    cboEventos = "<option value=''>Seleccione evento a participar</option>"
    if Not objRs.Eof then
        Do While Not objRs.Eof
            cboEventos = cboEventos & "<option value='" & objRs("Id_Evento") & "'>" & objRs("Descripcion") & "</option>"
            objRs.MoveNext
        Loop
    end if
    objRs.Close

    strQry = "Exec NACIONALIDADES_Lista_nacionalidades null"
    set objRs = objConn.Execute( strQry )
    cboNacionalidad = "<option value=''>Seleccione nacionalidad</option>"
    if Not objRs.Eof then
        Do While Not objRs.Eof
            cboNacionalidad = cboNacionalidad & "<option value='" & objRs("nacionalidad") & "'>" & objRs("nacionalidad") & "</option>"
            objRs.MoveNext
        Loop
    end if
    objRs.Close

    cboSexo = cboSexo & "<option value='M'>Masculino</option>"
    cboSexo = cboSexo & "<option value='F'>Femenino</option>"
    cboSexo = cboSexo & "<option value='N'>No Binario</option>"
    cboSexo = cboSexo & "<option value='X'>Prefiero no decirlo</option>"

    cboCiudad = "<select class='form-control' id='cboCiudad' name='cboCiudad' required><option value=''></option></select>"

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
            background-color: #949599;
        }
        .nav-tabs .nav-link.active {
            background-color: #ED3529;
            color: white;
        }
        .nav-tabs .nav-link.visited  {
            background-color: #ED3529;
            color: white;
        }

        .contenedor-personalida{
            background-color: #f0f0f0;
            border-radius: 20px;
            padding: 20px;
            margin: 20px auto; 
        }

        .tab-content-personal{
            background-color: #8fce00;
            border-radius: 0px;
        }

        .card-personal{
            background-color: #5c7c12;
            border-radius: 20px;
        }

         
        .btn-primary {
            color: #fff;
            background-color: #5c7c12;
            border-color: #5c7c12;
        }

        .btn-primary:hover {
            color: #fff;
            background-color: #5c7c12;
            border-color: #fff;
        }


    </style>
</head>
<body>
    <form id="frmRegistro" name="frmRegistro" method="post" action="procesar_formulario.asp">
        <div class="container mt-5 contenedor-personalida">
            <div class="card">
                <div class="card-header card-personal">
                    <h4>Formulario de Inscripción</h4>
                </div>
                <div class="card-body tab-content-personal">
                    <!--
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="info-personal-tab" data-toggle="tab" href="#info-personal" role="tab" aria-controls="info-personal" aria-selected="true">Información Personal</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="cualidades-fisicas-tab" data-toggle="tab" href="#cualidades-fisicas" role="tab" aria-controls="cualidades-fisicas" aria-selected="false">Cualidades Físicas</a>
                            </li>
                        </ul> 
                    -->
                    <div class="tab-content " id="myTabContent">
                        <!-- Información Personal -->
                        <div class="tab-pane fade show active" id="info-personal" role="tabpanel" aria-labelledby="info-personal-tab">
                                <div class="row justify-content-start">
                                    <div class="form-group mt-3 col-md-12">
                                        <label for="eventos">Evento a participar:</label>
                                        <select class="form-control" id="eventos" name="eventos" required>
                                            <% response.write cboEventos %>
                                        </select>
                                    </div>
                                </div>

                                <div class="row justify-content-start">
                                    <div class="form-group mt-3 col-md-6">
                                        <label for="tipo">Tipo:</label>
                                        <select class="form-control" id="tipo" name="tipo" required>
                                            <option value="C">Cedula Nacional</option>
                                            <option value="P">Pasaporte</option>
                                        </select>
                                    </div>
                                    <div class="form-group mt-3 col-md-6">
                                        <label for="numero_documento">Nro. documento:</label>
                                        <input type="text" class="form-control" id="numero_documento" name="numero_documento" size='20' maxlength='20' required oninput="checkRut(this)" >
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
                                
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="direccion">Direccion:</label>
                                        <input type="text" class="form-control" id="direccion" name="direccion" size='100' maxlength='100' required>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-4">
                                        <label for="email">Correo Electrónico:</label>
                                        <input type="email" class="form-control" id="email" name="email" size='50' maxlength='50' required>
                                    </div>
                                
                                    <div class="col-md-4">
                                        <label for="telefono">Teléfono:</label>
                                        <input type="tel" class="form-control" id="telefono" name="telefono" required>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="fecha_nacimiento">Fecha nacimiento:</label>
                                        <input type="date" class="form-control" id="fecha_nacimiento" name="fecha_nacimiento" required>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <label for="nacionalidad">Nacionalidad:</label>
                                        <select class="form-control" id="nacionalidad" name="nacionalidad" required>
                                            <% response.write ( cboNacionalidad ) %>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="sexo">Sexo:</label>
                                        <select class="form-control" id="sexo" name="sexo" required>
                                            <% response.write ( cboSexo ) %>
                                        </select>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <label for="pais">Pais:</label>
                                        <select class="form-control" id="pais" name="pais" required onchange="javascript:jsCargaCiudad( this.value )" >
                                            <% response.write ( cboPais ) %>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="ciudad">Ciudad:</label>
                                        <div id="divciudad">
                                            <select class='form-control' id='ciudad' name='ciudad' required>
                                                <% response.write ( cboCiudad ) %>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                         
                        </div>
                    </div>
                    <!-- Botón de Envío -->
                    <button type="submit" class="btn btn-primary mt-3 btn-registro-personalizada" >Registrarse</button>
                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script src="../includes/client/valida_rut.js"></script>

    <script>

        $(document).ready(function() {
            $('#frmRegistro').on('submit', function(e) {
                e.preventDefault(); // Evita el envío tradicional del formulario
                $.ajax({
                    type: 'POST',
                    url: 'registrar.asp', // La URL del script ASP que procesará el formulario
                    data: $(this).serialize(), // Serializa los datos del formulario
                    success: function(response) {
                        var aData = response.split("@");
                        var MensajeError = aData[1];
                        if ( aData[0] == "N" )
                        {
                            xIcon = "success";
                        }
                        else{
                            xIcon = "error";
                        }

                        Swal.fire({
                            position: "top-end",
                            icon: xIcon,
                            title: MensajeError,
                            showConfirmButton: true,
                            position: 'center' //,timer: 3000
                        });

                    },
                    error: function() {
                        Swal.fire({
                                position: "center",
                                icon: error,
                                title: "Hubo un error al enviar el formulario.",
                                showConfirmButton: false,
                                timer: 3000
                            });
                    }
                });
            });
        });


        function jsCargaCiudad( valor )
        {
            // Datos a enviar en la solicitud GET (como parámetros de la URL)
            var params = {
                pais: valor
            };

            // Convertir el objeto 'params' a una cadena de parámetros de URL codificada
            var queryString = $.param(params);

            // Configuración de la solicitud AJAX
            $.ajax({
                url: 'carga_ciudades.asp?' + queryString,              // URL del archivo PHP u otro recurso
                method: 'GET',                  // Método HTTP (GET, POST, PUT, DELETE, etc.)
                dataType: 'html',                // Tipo de datos que esperas recibir del servidor (json, xml, html, text, etc.)
                beforeSend: function(xhr) {
                    //console.log('Enviando solicitud...');
                },
                success: function(response, status, xhr) {
                    $("#divciudad").html(response);
                },
                error: function(xhr, status, error) {
                    // Función que se ejecuta si hay algún error en la solicitud
                    console.log('Hubo un problema con la solicitud:', status);
                    console.log('Error:', error);
                },
                complete: function(xhr, status) {
                    //console.log('Solicitud completada.');
                }
            });
        }
    </script>


    </body>
    </html>
