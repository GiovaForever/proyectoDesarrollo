﻿$(document).ready(function () {

    cargarLaboratoristas();
    cargarDocentes();
    cargarInventario();
    configuracionInicial();
    cargarNumeroPrestamo();
    cargarFecha();

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

    $("#btnAgregar").click(function () {

        var cantStock = $("#txtCantExis").val();
        var cantPrestamo = $("#txtCantidad").val();

        if (cantPrestamo !== "" && cantPrestamo !== "0") {
            var actualizar = false;
            var contador = 0;
            var eliminar = 0;

            tableDetail.rows().data().each(function (value) {
                if (value[1] === $("#txtNombreInventario").val()) {
                    cantPrestamo = Number(cantPrestamo) + Number(value[3]);
                    actualizar = true;
                    eliminar = contador;
                }
                contador = contador + 1;
            });

            if (Number(cantPrestamo) <= Number(cantStock)) {

                if (actualizar !== false) {
                    tableDetail.row(eliminar).remove();
                }

                tableDetail.row.add([
                    $("#txtId").val(),
                    $("#txtNombreInventario").val(),
                    $("#txtCategoria").val(),
                    cantPrestamo
                ]).draw(false);

                limpiarCamposInventario();

            } else {
                alertify.error("Error Stock Insuficiente. ");
                $("#txtCantidad").focus();
            }
        } else {
            alertify.error("La Cantidad No Puede Ser 0");
            $("#txtCantidad").focus();
        }
    });

    $('#tbl_Detalle tbody').on('click', 'tr', function (e) {
        tableDetail.$('tr.selected').removeClass('selected');
        $(this).addClass('selected');
        if (confirm("Esta Seguro De Quitar Item") === true) {
            tableDetail.row('.selected').remove().draw(false);
        } else {
            $(this).removeClass('selected');
        }
        e.stopPropagation();
    });

    $("#btnGuardar").click(function () {

        if (confirm("Esta Seguro De Guardar") === true) {
            if (tableDetail.rows().count() !== "0") {
                guardarPrestamo(tableDetail);
            } else {
                alertify.error("No Existen Item Para Registrar");
            }
        }

    });

});

function guardarPrestamo(tableDetail) {
    var numPrestamo = $("#txtNumeroPrestamo").val();
    var fechaPrestamo = $("#txtFecha").val();
    var cedulaUsuario = $("#txtCedulaDocente").val();
    var cedulaLaboratorista = $("#txtCedulaLaboratorista").val();
    var detail = obtenerDataDetalle(tableDetail);
    var dataComplete = "{'idPrestamo':'" + numPrestamo + "','cedulaUsuario':'" + cedulaUsuario + "','cedulaLaboratorista':'" +
        cedulaLaboratorista + "','fechaPrestamo':'" + fechaPrestamo + "','estadoPrestamo':'0','lstDetalle':" + detail + "}";

    $.ajax({
        type: "POST",
        url: "https://localhost:44315/api/PrestamosDocentes",
        data: dataComplete,
        contentType: "application/json;charset=utf-8",
        error: function (xhr, ajaxOptions, ThrownError) {

            var mensaje = "";

            if (xhr.status === 404) {
                mensaje = xhr.responseJSON;
            } else {
                mensaje = "Servidor No Disponible. Consulte Soporte."
            }

            alertify.error("Error: " + mensaje);

        },
        success: function (data) {
            alertify.success("Prestamo Registrado Correctamente");
            limpiarCampos(tableDetail);
        }
    });
}

function limpiarCampos(tableDetail) {
    cargarNumeroPrestamo();
    cargarFecha();
    configuracionInicial();
    $("#txtCedulaDocente").val("");
    $("#txtCedulaLaboratorista").val("");
    $("#txtDatosDocente").val("");
    $("#txtDatosLaboratorista").val("");
    $("#txtCantExis").val("");
    $("#txtId").val("");
    $("#tbl_Detalle").dataTable().fnClearTable();
    $("#tbl_Inventario").dataTable().fnClearTable();
    loadTableInventario();
}

function obtenerDataDetalle(tableDetail) {

    var data = "[";

    tableDetail.rows().data().each(function (value) {
        data = data + "{'cantidadPrestamo':'" + value[3] +
            "','idInventario': '" + value[0] + "','observacion': ''},";
    });
    data = data.substring(0, data.length - 1);
    data = data + "]"

    return data;

}

function cargarNumeroPrestamo() {

    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/values/prestamoDocente",
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
            $("#txtNumeroPrestamo").val(data);
        }
    });

}

function cargarFecha() {

    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/values/date",
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
            $("#txtFecha").val(data);
        }
    });

}

function limpiarCamposInventario() {
    $("#txtCategoria").val("");
    $("#txtNombreInventario").val("");
    $("#txtCantidad").val("");
    $("#btnAgregar").prop("disabled", true);
}

function configuracionInicial() {
    $("#btnBuscarDocente").prop("disabled", true);
    $("#btnBuscarInventario").prop("disabled", true);
    $("#btnAgregar").prop("disabled", true);
    $("#btnGuardar").prop("disabled", true);
    $("#btnBuscarLaboratorista").focus();
}

//Cargar Tabla Laboratoristas
function cargarLaboratoristas() {

    var table = $('#tbl_Laboratoristas').DataTable();
    table.clear();
    loadTableLaboratorista();

    $('#tbl_Laboratoristas tbody').on('click', 'tr', function () {
        datosTabla = table.row(this).data();
        $('input[type=search]').val('').change();
        $(this).removeClass('selected');
        table.search('').draw();
        $("#txtCedulaLaboratorista").val(datosTabla[0]);
        var datos = datosTabla[1] + " " + datosTabla[2];
        $("#txtDatosLaboratorista").val(datos);
        $("#btnBuscarDocente").prop("disabled", false);
        $("#btnBuscarDocente").focus();
        $("#ModalLaboratorista").modal('toggle');
    });

}

function loadTableLaboratorista() {

    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/Laboratoristas",
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
            addRowLaboratoristas(data);
        }
    });
}

function addRowLaboratoristas(data) {
    try {
        var table = $("#tbl_Laboratoristas").dataTable();

        for (var i = 0; i < data.length; i++) {
            table.fnAddData([
                data[i].cedulaLaboratorista,
                data[i].nombreLaboratorista,
                data[i].apellidoLaboratorista
            ]);
        }

    } catch (e) {
        alertify.error(e)
    }
}

//Cargar Tabla Docentes
function cargarDocentes() {

    var table = $('#tbl_Docentes').DataTable();
    table.clear();
    loadTableDocente();

    $('#tbl_Docentes tbody').on('click', 'tr', function () {
        datosTabla = table.row(this).data();
        $('input[type=search]').val('').change();
        $(this).removeClass('selected');
        table.search('').draw();
        $("#txtCedulaDocente").val(datosTabla[0]);
        var datos = datosTabla[1] + " " + datosTabla[2];
        $("#txtDatosDocente").val(datos);
        $("#btnBuscarInventario").prop("disabled", false);
        $("#btnBuscarInventario").focus();
        $("#ModalDocente").modal('toggle');
    });

}

function loadTableDocente() {

    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/Docentes",
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
            addRowDocentes(data);
        }
    });
}

function addRowDocentes(data) {
    try {
        var table = $("#tbl_Docentes").dataTable();

        for (var i = 0; i < data.length; i++) {
            table.fnAddData([
                data[i].cedulaDocente,
                data[i].nombreDocente,
                data[i].apellidoDocente
            ]);
        }

    } catch (e) {
        alertify.error(e)
    }
}

//Cargar Tabla Inventario
function cargarInventario() {

    var table = $('#tbl_Inventario').DataTable({
        columnDefs: [
            {
                targets: 0,
                width: "40%",
                className: "dt-center"
            }, {
                targets: 1,
                width: "40%",
            }, {
                targets: 2,
                width: "20%"
            }
        ]
    });
    table.clear();
    loadTableInventario();
    table.column(0).visible(false);
    table.column(3).visible(false);

    $('#tbl_Inventario tbody').on('click', 'tr', function () {
        datosTabla = table.row(this).data();
        $('input[type=search]').val('').change();
        $(this).removeClass('selected');
        table.search('').draw();
        $("#txtCategoria").val(datosTabla[4]);
        $("#txtNombreInventario").val(datosTabla[1]);
        $("#txtId").val(datosTabla[0]);
        $("#txtCantExis").val(datosTabla[2]);
        $("#btnAgregar").prop("disabled", false);
        $("#txtCantidad").focus();
        $("#btnGuardar").prop("disabled", false);
        $("#ModalInventario").modal('toggle');
    });

}

function loadTableInventario() {

    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/Inventarios",
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
            addRowInventario(data);
        }
    });
}

function addRowInventario(data) {
    try {
        var table = $("#tbl_Inventario").dataTable();

        for (var i = 0; i < data.length; i++) {
            table.fnAddData([
                data[i].idInventario,
                data[i].nombreInventario,
                data[i].cantidadInventario,
                data[i].idCategoria,
                data[i].nombreCategoria
            ]);
        }

    } catch (e) {
        alertify.error(e)
    }
}