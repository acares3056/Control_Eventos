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
  <title>Formulario de Búsqueda de Clientes</title>

  <!-- Archivos CSS de Bootstrap -->
  <link rel="stylesheet" href="https://cdn.datatables.net/2.0.5/css/dataTables.dataTables.min.css">
  
<!--  <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.dataTables.min.css"> -->

  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <style>
    /* Personalización adicional si es necesario */
    #loadingIndicator {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            display: none;
            z-index: 9999; /* Asegura que el spinner esté encima de todos los demás elementos */
            background-color: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .full-width-btn {
      width: 100%;
    }
    .custom-width-form {
      width: 100%;
      margin: 0 auto; /* Para centrar el formulario horizontalmente */
    }
    .custom-width-container {
      width: 90%;
      margin: 0 auto; /* Para centrar el contenedor horizontalmente */
    }
    table thead{
        background-color: #7092FF;
        color: white;
    }
  </style>
</head>
<body>

<div class="custom-width-container  mt-5 ">
  <h2 class="mb-4">Búsqueda de Clientes</h2>
  <form id="searchForm">
    <div class="form-row">
      <div class="col-md-4 mb-3">
        <label for="nombre">Nombre:</label>
        <input type="text" class="form-control" id="nombre" name="nombre">
      </div>
      <div class="col-md-4 mb-3">
        <label for="apellidos">Apellidos:</label>
        <input type="text" class="form-control" id="apellidos" name="apellidos">
      </div>
      <div class="col-md-4 mb-3">
        <label for="direccion">Dirección:</label>
        <input type="text" class="form-control" id="direccion" name="direccion">
      </div>
    </div>
    <div class="form-row">
      <div class="col-md-6 mb-3">
        <button type="submit" class="btn btn-primary full-width-btn">Buscar</button>
      </div>
      <div class="col-md-6 mb-3">
        <button type="button" class="btn btn-danger full-width-btn" id="salirBtn" onClick="fnSalirBtn()">Salir</button>
      </div>
    </div>
  </form>
  
  <!-- Indicador de carga -->
  <div id="loadingIndicator">
    <div class="spinner-border text-primary" role="status">
      <span class="sr-only">Cargando...</span>
    </div>
    <span>Cargando...</span>
  </div>


  <div class="modal fade" id="detalleModal" tabindex="-1" aria-labelledby="detalleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="detalleModalLabel">Cliente - Entrega Accesorios</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <form id="actualizaVestimenta">
          <div class="modal-body">
            <div id="detalleCliente"></div>
          </div>
        </form>
      </div>
    </div>
  </div>


  <div id="resultados" class="mt-4"></div>
</div>

<!-- Archivos JavaScript de Bootstrap y jQuery (necesarios para AJAX) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.datatables.net/2.0.5/js/dataTables.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- <script src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script> -->

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>

  $(document).ready(function(){
    $('#searchForm').submit(function(event){
      event.preventDefault();
      $.ajax({
        type: 'POST',
        url: 'search_data.asp',
        data: $(this).serialize(),
        beforeSend: function() {
          $('#loadingIndicator').show(); // Mostrar el indicador de carga
        },
        success: function(response){
          
          $('#resultados').html(response);

          var tabla = $('#tablaClientes').DataTable( {
              responsive: true,
              language: {
                    processing: 'Procesando...',
                    lengthMenu: 'Mostrar _MENU_ registros',
                    zeroRecords: 'No se encontraron resultados',
                    emptyTable: 'Ningún dato disponible en esta tabla',
                    infoEmpty: 'Mostrando registros del 0 al 0 de un total de 0 registros',
                    infoFiltered: '(filtrado de un total de _MAX_ registros)',
                    search: 'Buscar:',
                    infoThousands: ',',
                    loadingRecords: 'Cargando...',
                    paginate: {
                      first: 'Primero',
                      last: 'Último',
                      next: 'Siguiente',
                      previous: 'Anterior',
                    },
                    info: "Registro _START_ - _END_ de _TOTAL_ "
                },
                searching: false
            }
          );
        

        },
        error: function(xhr, status, error){
          var txtResp = "";
          var imageIcon = "question";
          if(xhr.status == 404) {
            // Manejar el error 404 (Recurso no encontrado)
            txtResp = 'Error: Recurso no encontrado.';
            imageIcon = "error";
          } else if(xhr.status == 500) {
            // Manejar el error 500 (Error interno del servidor)
            txtResp = 'Error: Error interno del servidor.';
            imageIcon = "error";
          } else {
            // Otros errores
            txtResp = 'Error: ' + error + '\n Estado: ' + status;
            imageIcon = "error";
          }
          Swal.fire({
            title: 'Advertencia!',
            text: txtResp,
            icon: imageIcon,
            confirmButtonText: 'Entendido'
          });
        },
        complete: function(){
          $('#loadingIndicator').hide(); // En caso de error, ocultar el indicador de carga
        }

      });
    });
  });

function fnEntrega(id) {
    parent.top.location.href = "detalle_cliente.asp?id=" + id + "&rnd=" + Math.random();
}

function fnSalirBtn(){
    parent.top.location.href = "default.asp?rnd=" + Math.random();
}

</script>

</body>
</html>
