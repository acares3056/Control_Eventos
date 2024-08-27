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

        .checkbox-lg .form-check-input{
            top: .8rem;
            scale: 1.4;
            margin-right: 0.7rem;
        }

        .checkbox-lg .form-check-label {
            padding-top: 13px;
        }

        .checkbox-xl .form-check-input {
            top: 1.2rem;
            scale: 1.7;
            margin-right: 0.8rem;
        }

        .checkbox-xl .form-check-label {
            padding-top: 22px;
        }
 

    </style>
</head>
<%
'On Error Resume Next

DisableCache()

txtMensaje = ""
txtError = "N"

Set objConn = AbrirConnDB()

qr_code = Sanitize( request("codigo_qr") )

' Construir la consulta SQL
strQuery = "Execute CLIENTES_Lista_clientes Null, Null, Null, Null, '" & qr_code & "'"
Set objRs = objConn.Execute(strQuery)

' Mostrar resultados
If objRs.EOF Then
    txtError = "S"
    txtMensaje = "No hay registros asociados a este codigo QR."
    
    Response.clear
    Response.Write txtError & ";" & txtMensaje
    Response.end
Else 

    if request("soloconsulta") = "S" Then
        Response.clear
        Response.Write txtError & ";" & txtMensaje
        Response.end
    end if

    id = objRs("ID")
    id_evento = objRs("ID_Evento")
    Rut       = objRs("Rut/Dni/Pasaporte")
    nombre    = objRs("nombres")
    apellidos = objRs("apellidos")
    direccion = objRs("direccion")
    ciudad    = objRs("ciudad")
    nombre_club = objRs("nombre_de_club")
    email       = objRs("email")
end if
objRs.Close()

%>

    <form id="frmRegistro" name="frmRegistro" method="post" action="procesar_formulario.asp">
        <div class="container mt-5 contenedor-personalida">
            <div class="card">
                <div class="card-header card-personal">
                    <h4>Entrega de Instrumentos o Accesorios</h4>
                </div>
                <div class="card-body tab-content-personal">
                    <div class="tab-content " id="myTabContent">
                        <!-- Información Personal -->
                        <div class="tab-pane fade show active" id="info-personal" role="tabpanel" aria-labelledby="info-personal-tab">
                                <div class="row justify-content-start">
                                    <div class="form-group mt-3 col-md-6">
                                        <label for="numero_documento">Nro. documento:</label>
                                        <input readonly type="text" class="form-control" id="numero_documento" name="numero_documento" size='20' maxlength='20' value="<%=Rut%>">
                                        <input type="hidden" id="id_evento" name="id_evento" value="<%=id_evento%>">
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <label for="nombre">Nombres:</label>
                                        <input type="text" class="form-control" id="nombre" name="nombre" size='50' maxlength='50' value="<%=nombre%>">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="apellido">Apellidos:</label>
                                        <input type="text" class="form-control" id="apellido" name="apellido" size='50' maxlength='50'  value="<%=apellidos%>">
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <label for="direccion">Direccion:</label>
                                        <input type="text" class="form-control" id="direccion" name="direccion" size='100' maxlength='100'  value="<%=direccion%>">
                                    </div>
                                
                                
                                    <div class="col-md-6">
                                        <label for="email">Correo Electrónico:</label>
                                        <input type="email" class="form-control" id="email" name="email" size='50' maxlength='50'  value="<%=email%>">
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12 text-center ">
                                        <label><h4>Accesorios Retirados</h4></label>
                                    </div>
                                </div>

                                <div class="row text-center">
                                <%
                                    cSql = "Exec EVENTOS_lista_accesorios_habilitados 0" & id_evento
                                    set objRs = objConn.Execute ( cSql )
                                    Do While Not objRs.Eof %>

                                        <div class="col-md-4 form-check checkbox-xl">
                                            <label class="form-check-label" >
                                                <input class="form-check-input" type="checkbox" id="accesorio_<%=i%>" name="accesorio_<%=i%>" value="<%=objRs("codigo_accesorio")%>">
                                                <%=objRs("descripcion_accesorio")%>
                                            </label>
                                        </div>
                                    
                                <%
                                        objRs.MoveNext
                                    Loop
                                    objRs.Close
                                %>
                                </div>

                        </div>
                    </div>

                    <!-- Botón de Envío -->
                    <div class="text-center">
                        <button type="button" class="btn btn-primary mt-3 btn-registro-personalizada" onclick="javascript:fnConfirmar()">Confirmar entrega</button>
                        <button type="button" class="btn btn-primary mt-3 btn-registro-personalizada" onclick="javascript:fnVolver()">Cancelar</button>
                    </div>

                </div>

                

            </div>
        </div>
    </form>

<% 
' Limpiar y cerrar recursos

objConn.Close
Set objConn = Nothing
%>

<!-- Archivos JavaScript de Bootstrap y jQuery (necesarios para AJAX) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>

    function fnConfirmar(){
        var retirados = "";
        for (let i=0; i < document.frmRegistro.elements.length; i++) {
            if(document.frmRegistro.elements[i].type === "checkbox") {
                var elemento = document.frmRegistro.elements[i];
                if ( elemento.checked ){
                    retirados += elemento.value + ';';
                }
            }
        }

        if ( retirados == "" ) {
            Swal.fire({
                  title: 'Advertencia!',
                  text: "No ha seleccionado ningun accesorio que viene a retirar.",
                  icon: "error",
                  confirmButtonText: 'ACEPTAR'
                });
            return;
        }
 
        // Datos a enviar en la solicitud GET (como parámetros de la URL)
        var params = {
            retirados: retirados
        };

        // Convertir el objeto 'params' a una cadena de parámetros de URL codificada
        var queryString = $.param(params);

        // Configuración de la solicitud AJAX
        $.ajax({
            url: 'actualiza_entrega.asp?' + queryString,              // URL del archivo PHP u otro recurso
            method: 'GET',                  // Método HTTP (GET, POST, PUT, DELETE, etc.)
            dataType: 'html',                // Tipo de datos que esperas recibir del servidor (json, xml, html, text, etc.)
            beforeSend: function(xhr) {
                //console.log('Enviando solicitud...');
            },
            success: function(response, status, xhr) {
                alert ( response );
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

    function fnVolver(){
        parent.top.location.href = "metodo_captura.asp?rnd=" + Math.random();
    }

</script>
