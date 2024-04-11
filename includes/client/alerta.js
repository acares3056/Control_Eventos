    function mostrarMensaje(mensaje, tipo) {
        const alertContainer = document.getElementById("alert-container");
        
        // Crea un elemento de alerta de Bootstrap
        const alertDiv = document.createElement("div");
        alertDiv.classList.add("alert", `alert-${tipo}`, "alert-dismissible", "fade", "show");
        alertDiv.innerHTML = `
            <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                <span aria-hidden="true">&times;</span>
            </button>
            ${mensaje}
        `;

        // Agrega la alerta al contenedor
        alertContainer.appendChild(alertDiv);

        // Cierra la alerta después de 5 segundos (5000 milisegundos)
        setTimeout(function() {
            alertDiv.classList.remove("show");
            setTimeout(function() {
                alertContainer.removeChild(alertDiv);
            }, 300); // Asegura que la animación de desaparición termine antes de eliminarla
        }, 1500);
    }

    // Ejemplo de uso:
    //mostrarMensaje("Inicio de sesión exitoso", "success");
    //mostrarMensaje("Error al iniciar sesión. Por favor, inténtalo de nuevo.", "danger");
