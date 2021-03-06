﻿$(document).ready(function () {

    cargarTablaPrestamos();

});

function limpiarCampos() {
    $("#txtNumeroPrestamo").val("");
    $("#txtFecha").val("");
    $("#txtCedulaInvitado").val("");
    $("#txtDatosInvitado").val("");
    $("#txtCedulaLaboratorista").val("");
    $("#txtDatosLaboratorista").val("");
    $("#btnGuardar").prop("disabled", true);
    $("#btnLimpiar").prop("disabled", true);
    $("#tbl_Detalle").dataTable().fnClearTable();
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
        $("#txtFecha").val(datosTabla[1]);
        $("#txtCedulaInvitado").val(datosTabla[2]);
        $("#txtDatosInvitado").val(datosTabla[3]);
        $("#txtCedulaLaboratorista").val(datosTabla[4]);
        $("#txtDatosLaboratorista").val(datosTabla[5]);
        $("#tbl_Detalle").dataTable().fnClearTable();
        $("#btnGuardar").prop("disabled", false);
        $("#btnLimpiar").prop("disabled", false);
        loadTableDetalle();
        $("#ModalPrestamos").modal('toggle');
    });
}

function loadTablePrestamos() {
    $("#tbl_Prestamos").dataTable().fnClearTable();
    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/PrestamosInvitados",
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
        url: "https://localhost:44315/api/PrestamosInvitados/DetallePrestamos?idPrestamo=" + $("#txtNumeroPrestamo").val(),
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
            console.log(data);
            addRowDetalle(data);
        }
    });
}

function addRowDetalle(data) {
    try {
        var table = $("#tbl_Detalle").dataTable();

        for (var i = 0; i < data.length; i++) {
            table.fnAddData([
                data[i].idInventario,
                data[i].nombreInventario,
                data[i].nombreCategoria,
                data[i].cantidadPrestamo
            ]);
        }

    } catch (e) {
        alertify.error(e)
    }
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