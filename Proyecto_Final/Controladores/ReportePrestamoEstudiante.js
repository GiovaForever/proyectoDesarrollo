$(document).ready(function () { 

    cargarTablaPrestamos();
    $("#btnGuardar").prop("disabled", true);
    $("#btnLimpiar").prop("disabled", true);
    var tableDetail = $("#tbl_Detalle").DataTable({
        paging: false,
        info: false,
        searching: false,
        ordering: false,
        columnDefs: [
            {
                targets: 0,
                width: "15%",
                className: "dt-center"
            }, {
                targets: 1,
                width: "40%",
            }, {
                targets: 2,
                width: "30%"
            }, {
                targets: 3,
                width: "15%",
                className: "dt-center"
            }
        ]
    });
    $("#btnGuardar").click(function () {

        if (confirm("Esta Seguro De Guardar") === true) {
            guardarPrestamo(tableDetail);
            limpiarCampos();
        }

    });

    $("#btnLimpiar").click(function () {
        if (confirm("¿Está Seguro De Limpiar Los Campos?")) {
            limpiarCampos();
        }
    });

});

function limpiarCampos() {
    $("#txtNumeroPrestamo").val("");
    loadTablePrestamos();
}

function cargarTablaPrestamos() {
    var table = $('#tbl_Prestamos').DataTable();
    table.clear();
    loadTablePrestamos();

    $('#tbl_Prestamos tbody').on('click', 'tr', function () {
        datosTabla = table.row(this).data();
        $('input[type=search]').val('').change();
        $(this).removeClass('selected');
        table.search('').draw();
        $("#txtNumeroPrestamo").val(datosTabla[0]);
        loadTableDetalle();
    });
}

function loadTablePrestamos() {
    $("#tbl_Prestamos").dataTable().fnClearTable();
    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/PrestamosEstudiantes",
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
            addRowPrestamos(data);
        }
    });
}

function addRowPrestamos(data) {
    try {
        var table = $("#tbl_Prestamos").dataTable();

        for (var i = 0; i < data.length; i++) {
            table.fnAddData([
                data[i].idPrestamo,
                data[i].fechaPrestamo,
                data[i].cedulaEstudiante,
                data[i].nombreEstudiante + " " + data[i].apellidoEstudiante,
                data[i].cedulaLaboratorista,
                data[i].nombreLaboratorista + " " + data[i].apellidoLaboratorista
            ]);
        }

    } catch (e) {
        alertify.error(e)
    }
}

//Cargar Detalle

function loadTableDetalle() {
    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/PrestamosEstudiantes/DetallePrestamos?idPrestamo=" + $("#txtNumeroPrestamo").val(),
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
            addRowDetalle(data);
        }
    });
}


function obtenerDataDetalle(tableDetail) {

    var data = "[";

    tableDetail.rows().data().each(function (value) {
        data = data + "{'cantidadPrestamo':'" + value[3] +
            "','idInventario': '" + value[0] + "','observacion': 'Ninguna'},";
    });
    data = data.substring(0, data.length - 1);
    data = data + "]"

    return data;

}