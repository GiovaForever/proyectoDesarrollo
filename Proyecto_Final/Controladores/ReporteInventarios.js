$(document).ready(function () {
    $("#cmbCategoria").change(function () {
        if ($("#cmbCategoria").val() !== "-1") {
            var tipo = $("#cmbCategoria").val();
            $("#txt1").val(tipo);
        }
    });
    obtenerCategorias();

});


function obtenerCategorias() {
    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/Categorias",
        data: {},
        contentType: "application/json;charset=utf-8",
        error: function (xhr, ajaxOptions, ThrownError) {

            if (xhr.status === 404) {
                var mensaje = xhr.responseJSON;
            } else {
                mensaje = "Servidor No Disponible. Consulte Soporte."
            }

            alertify.error("Error: " + mensaje);
        },
        success: function (data) {
            cargarCategorias(data)
        }
    });
}

function cargarCategorias(data) {
    var html_code = '<option value="-1">---Seleccione---</option>';
    $.each(data, function (key, value) {
        html_code += '<option value="' + value.idCategoria + '">' + value.nombreCategoria + '</option>';
    });
    $("#cmbCategoria").html(html_code);
}

