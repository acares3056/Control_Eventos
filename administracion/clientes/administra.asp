<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulario de Clientes</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        /* Personalización de tonalidades azules */
        body {
            background-color: #f8f9fa;
        }
        .container {
            background-color: #ffffff;
            margin-top: 50px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px #888888;
            padding: 30px;
        }
        h2 {
            color: #007bff;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Formulario de Cliente</h2>
        <form>
            <div class="form-group">
                <label for="nombre">Nombre</label>
                <input type="text" class="form-control" id="nombre" placeholder="Ingrese nombre">
            </div>
            <div class="form-group">
                <label for="apellido">Apellido</label>
                <input type="text" class="form-control" id="apellido" placeholder="Ingrese apellido">
            </div>
            <div class="form-group">
                <label for="email">Correo Electrónico</label>
                <input type="email" class="form-control" id="email" placeholder="Ingrese correo electrónico">
            </div>
            <div class="form-group">
                <label for="telefono">Teléfono</label>
                <input type="tel" class="form-control" id="telefono" placeholder="Ingrese teléfono">
            </div>
            <div class="form-group">
                <label for="direccion">Dirección</label>
                <input type="text" class="form-control" id="direccion" placeholder="Ingrese dirección">
            </div>
            <div class="form-group">
                <label for="ciudad">Ciudad</label>
                <input type="text" class="form-control" id="ciudad" placeholder="Ingrese ciudad">
            </div>
            <div class="form-group">
                <label for="pais">País</label>
                <input type="text" class="form-control" id="pais" placeholder="Ingrese país">
            </div>
            <div class="form-group">
                <label for="codigo_postal">Código Postal</label>
                <input type="text" class="form-control" id="codigo_postal" placeholder="Ingrese código postal">
            </div>
            <div class="form-group">
                <label for="fecha_nacimiento">Fecha de Nacimiento</label>
                <input type="date" class="form-control" id="fecha_nacimiento">
            </div>
            <div class="form-group">
                <label for="genero">Género</label>
                <select class="form-control" id="genero">
                    <option value="masculino">Masculino</option>
                    <option value="femenino">Femenino</option>
                    <option value="otro">Otro</option>
                </select>
            </div>
            <div class="form-group">
                <label for="intereses">Intereses</label>
                <input type="text" class="form-control" id="intereses" placeholder="Ingrese intereses">
            </div>
            <div class="form-group">
                <label for="notas">Notas</label>
                <textarea class="form-control" id="notas" rows="3" placeholder="Ingrese notas"></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Guardar</button>
        </form>
    </div>

    <!-- Bootstrap JS y jQuery (opcional, solo si necesitas funcionalidades JS) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
