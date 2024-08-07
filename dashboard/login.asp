<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>Estadisticas - Login</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block" style="background: url('https://source.unsplash.com/random/?password') no-repeat center center; height: 100vh; display: flex; align-items: center; justify-content: center; margin: 0;">
                            </div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <hr>
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">Acceso Back-End</h1>
                                    </div>
                                    <hr>
                                    <form class="user">
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user"
                                                id="usuario" placeholder="Ingrese su usuario...">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user"
                                                id="contrasena" placeholder="Ingrese su contraseña">
                                        </div>
                                        <!-- 
                                        <div class="form-group">
                                            <div class="custom-control custom-checkbox small">
                                                <input type="checkbox" class="custom-control-input" id="customCheck">
                                                <label class="custom-control-label" for="customCheck">Remember
                                                    Me</label>
                                            </div>
                                        </div>
                                    -->
                                        <a href="#" class="btn btn-primary btn-user btn-block" onclick='fnAceptar()'>
                                            Aceptar
                                        </a>
                                        <!-- 
                                        <hr>
                                        <a href="index.html" class="btn btn-google btn-user btn-block">
                                            <i class="fab fa-google fa-fw"></i> Login with Google
                                        </a>
                                        <a href="index.html" class="btn btn-facebook btn-user btn-block">
                                            <i class="fab fa-facebook-f fa-fw"></i> Login with Facebook
                                        </a>
                                    -->
                                    </form>
                                    <hr>
                                <!--
                                    <div class="text-center">
                                        <a class="small" href="forgot-password.html">Forgot Password?</a>
                                    </div>
                                    <div class="text-center">
                                        <a class="small" href="register.html">Create an Account!</a>
                                    </div>
                                -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script type="text/javascript">
        function fnAceptar(){

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

                        location.replace('index.asp?rnd=' + Math.random() );

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
        }
    </script>

</body>

</html>