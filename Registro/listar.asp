<!DOCTYPE html>
<html>
<head>
    <title>Listado de Clientes</title>
    <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css">
</head>
<body>
    <table id="tablaClientes">
        <thead>
            <tr>
                <th>ID Cliente</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <!-- Aquí puedes agregar más columnas según tus necesidades -->
            </tr>
        </thead>
        <tbody>
            <!-- Aquí se cargarán los datos de los clientes -->
        </tbody>
    </table>

    <script>
        $(document).ready(function() {
            $('#tablaClientes').DataTable({
                "ajax": "obtener_clientes.asp" // Esta será la página ASP que proporcionará los datos de los clientes
            });
        });
    </script>
</body>
</html>
