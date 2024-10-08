<%

%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Administracion de Usuarios</title>

  <!-- Archivos CSS de Bootstrap -->
  <link rel="stylesheet" href="https://cdn.datatables.net/2.0.5/css/dataTables.dataTables.min.css">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <style>
    /* Personalización adicional si es necesario */
    #loadingIndicator {
      display: none;
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
  </style>
</head>
<body>

<div class="custom-width-container  mt-5 ">
  <h2 class="mb-4">Administracion de Eventos</h2>
  <form id="searchForm">
    <div class="form-row">
      <div class="col-md-12 mb-3">
        <label for="nombre">Evento:</label>
        <input type="text" class="form-control" id="nombre" name="nombre">
      </div>
      
    </div>
    <div class="form-row">
      <div class="col-md-6 mb-3">
        <button type="submit" class="btn btn-primary full-width-btn">Buscar</button>
      </div>
      <div class="col-md-6 mb-3">
        <button type="button" class="btn btn-secondary full-width-btn" id="salirBtn">Salir</button>
      </div>
    </div>
  </form>
  
  <!-- Indicador de carga -->
  <div id="loadingIndicator" class="mt-4">
    <div class="spinner-border text-primary" role="status">
      <span class="sr-only">Cargando...</span>
    </div>
    <span>Cargando...</span>
  </div>


  <div class="modal fade" id="detalleModal" tabindex="-1" aria-labelledby="detalleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="detalleModalLabel">Detalles del Cliente</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <div id="detalleCliente"></div>
        </div>
      </div>
    </div>
  </div>


  <div id="resultados" class="mt-4"></div>
</div>

<!-- Archivos JavaScript de Bootstrap y jQuery (necesarios para AJAX) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.datatables.net/2.0.5/js/dataTables.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
  $(document).ready(function(){
    $('#searchForm').submit(function(event){
      event.preventDefault();
      $.ajax({
        type: 'POST',
        url: 'administracion/eventos/search_data.asp',
        data: $(this).serialize(),
        beforeSend: function() {
          $('#loadingIndicator').show(); // Mostrar el indicador de carga
        },
        success: function(response){
          
          $('#resultados').html(response);

          var tabla = $('#tablaClientes').DataTable( {
              responsive: true,
              language: {
                    url: '//cdn.datatables.net/plug-ins/1.10.16/i18n/Spanish.json',
                    oPaginate: {
                        "sFirst": " << ",
                        "sLast":">> ",
                        "sNext":" > ",
                        "sPrevious": " < "
                    },
                    info: "Registro _START_ - _END_ de _TOTAL_ "
                },
                searching: false
            }
          );

          $('#tablaClientes tbody').on('click', 'tr', function() {
            var datosFila = tabla.row(this).data();
            mostrarDetalleCliente(datosFila);
          });

        },
        error: function(xhr, status, error){
          var txtResp = "";
          if(xhr.status == 404) {
            // Manejar el error 404 (Recurso no encontrado)
            txtResp = 'Error: Recurso no encontrado.';
          } else if(xhr.status == 500) {
            // Manejar el error 500 (Error interno del servidor)
            txtResp = 'Error: Error interno del servidor.';
          } else {
            // Otros errores
            txtResp = 'Error: ' + error + '\n Estado: ' + status;
          }
          Swal.fire({
            title: 'Advertencia!',
            text: txtResp,
            icon: 'warning',
            confirmButtonText: 'Entendido'
          });
        },
        complete: function(){
          $('#loadingIndicator').hide(); // En caso de error, ocultar el indicador de carga
        }

      });
    });

    $('#salirBtn').click(function(event){
      event.preventDefault();

        location.href = 'index.asp';

      });

  });

  function mostrarDetalleCliente(datosFila) {
      $('#detalleCliente').html(
        '<p><strong>Nombre:</strong> ' + datosFila[0] + '</p>' +
        '<p><strong>Apellidos:</strong> ' + datosFila[1] + '</p>' +
        '<p><strong>Dirección:</strong> ' + datosFila[2] + '</p>'
      );
      $('#detalleModal').modal('show');
    }

</script>

</body>
</html>
