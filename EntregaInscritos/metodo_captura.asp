<!-- #include file="../includes/server/config.asp" -->
<!-- #include file="../includes/server/fnDB.asp" -->

<%
    On Error Resume Next

    if len(trim(Session("scanid_Login"))) = 0 then 
        response.Redirect ( "default.asp")
    end if 

    DisableCache()

    Session("metodo_captura") = ""
    
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Selección de Cámara Web o Lector de Código de Barras</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .card {
            transition: transform 0.3s ease-in-out;
        }
        .card:hover {
            transform: scale(1.05);
        }
        .card-img-top {
            height: 200px;
            object-fit: cover;
        }
        .card-body {
            text-align: center;
        }

        .logout-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
        }
        .logout-btn:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>

        <button class="logout-btn" onclick="window.location.href='fin_sesion.asp';">Cerrar Sesion</button>


<div class="container">
    <div class="row text-center">
        <div class="col-md-6 mb-4">
            <div class="card shadow-sm border-primary">
                <img src="https://via.placeholder.com/500x300.png?text=Webcam" class="card-img-top" alt="Cámara Web">
                <div class="card-body">
                    <h5 class="card-title">Cámara Web</h5>
                    <p class="card-text">Utiliza tu cámara web para capturar imágenes o video.</p>
                    <a href="#" class="btn btn-primary" onclick="javascript:fnCamara()">Seleccionar</a>
                </div>
            </div>
        </div>
        <div class="col-md-6 mb-4">
            <div class="card shadow-sm border-success">
                <img src="https://via.placeholder.com/500x300.png?text=Scanner" class="card-img-top" alt="Lector de Código de Barras">
                <div class="card-body">
                    <h5 class="card-title">Lector de Código de Barras</h5>
                    <p class="card-text">Utiliza un lector de código de barras para escanear códigos.</p>
                    <a href="#" class="btn btn-success" onclick="javascript:fnLector()">Seleccionar</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Bootstrap JS and dependencies -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    function fnLector(){
        location.replace('lectura_cliente.asp?rnd=' + Math.random() );
    }
    
    function fnCamara(){
        location.replace('captura_cliente.asp?rnd=' + Math.random() );
    }
</script>

</body>
</html>
