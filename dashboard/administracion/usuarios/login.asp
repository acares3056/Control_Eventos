<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>SCANID - Iniciar Sesión</title>
  <!-- Enlace al archivo CSS de Bootstrap -->
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
  <style>
    /* Estilos personalizados */
    body {
      height: 100vh; /* Altura del 100% de la ventana del navegador */
      background: url('https://source.unsplash.com/random/300×300/?triathlon') no-repeat center center fixed;
      background-size: cover;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0;
    }
    .login-container {
      background-color: rgba(255, 255, 255, 0.8); /* Fondo difuminado */
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-4">
        <div class="login-container">
          <h3 class="text-center mb-4">Iniciar Sesión</h3>
          <form id="login-form">
            <div class="form-group">
              <label for="usuario">Usuario</label>
              <input type="text" class="form-control" id="usuario" name="usuario" required>
            </div>
            <div class="form-group">
              <label for="contrasena">Contraseña</label>
              <input type="password" class="form-control" id="contrasena" name="contrasena" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Iniciar Sesión</button>
          </form>
        </div>
      </div>
    </div>
  </div>

    <!-- mostrar mensajes -->
    <div id="alert-container" class="fixed-bottom mt-3 text-center w-100"></div>

    <!-- Agrega los enlaces a los archivos JavaScript de Bootstrap (jQuery y Popper.js) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- Agrega tu código JavaScript personalizado para la validación del usuario y el cambio de contraseña con AJAX -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

  <script>
        // Validación de usuario en el formulario de inicio de sesión
        $("#login-form").submit(function (e) {
            e.preventDefault();
            const usuario = $("#usuario").val();
            const seguridad = $("#contrasena").val();

            var regex = /^[a-zA-Z0-9]+$/;
            if (!regex.test(usuario) ) {                
                Swal.fire({
                  title: 'Advertencia!',
                  text: "El usuario ingresado debe contener solamente letras y numeros. Por favor, verificar ingreso de credenciales.",
                  icon: "error",
                  confirmButtonText: 'Entendido'
                });                
                return false;
            }

            if (!regex.test(seguridad) ) {                
                Swal.fire({
                  title: 'Advertencia!',
                  text: "La contraseña ingresada debe contener solamente letras y numeros. Por favor, verificar ingreso de credenciales.",
                  icon: "error",
                  confirmButtonText: 'Entendido'
                });
                return false;
            }


            // Realiza una llamada AJAX para validar el usuario (reemplaza esto con tu lógica real)
            $.ajax({
                url: "validacion_usuario.asp?rnd=" + Math.random(),
                method: "POST",
                data: {
                    usuario: usuario,
                    seguridad: seguridad
                },
                success: function (response) {
                    var data = JSON.parse(response);

                    if ( data.error == "N") {
                        location.replace('seleccion_evento.asp');
                    } else {
                        Swal.fire({
                          title: 'Advertencia!',
                          text: data.mensaje,
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
        });
    </script>
</body>
</html>
