$(document).ready(function () {
    cargarTablaDatos();
});


function limpiarCampos() {
    $("#txtCodigo").val("");
}
function loadDataTable(data) {
    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/LaboratoriosDocentes/laboratoriosOcupados?idDia=" + data,
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
            addRowTable(data);
        }
    });
}

function cargarTablaDatos(data) {
    var table = $('#tbl_Prestamos').DataTable();
    table.clear();
    table.column(0).visible(false);
    table.column(1).visible(false);
    table.column(2).visible(false);
    table.column(3).visible(false);
    table.column(6).visible(false);
    loadDataTable(data);

    $('#tbl_Prestamos tbody').on('click', 'tr', function () {
        datosTabla = table.row(this).data();
        $('input[type=search]').val('').change();
        $(this).removeClass('selected');
        table.search('').draw();
        $("#txtCodigo").val(datosTabla[0]);
    });

}

function addRowTable(data) {
    try {
        var table = $("#tbl_Prestamos").dataTable();

        for (var i = 0; i < data.length; i++) {
            table.fnAddData([
                data[i].idLabDocente,
                data[i].fechaPrestamo,
                data[i].nombreLaboratorista + " " + data[i].apellidoLaboratorista,
                data[i].idLaboratorio,
                data[i].nombreLaboratorio,
                data[i].nombreTipoLaboratorio,
                data[i].idMateria,
                data[i].nombreMateria,
                data[i].nombreDocente + " " + data[i].apellidoDocente,
                data[i].horario
            ]);
        }

    } catch (e) {
        alertify.error(e)
    }
}