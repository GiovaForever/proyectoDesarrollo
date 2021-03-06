﻿$(document).ready(function () {

    var usuarioRol = localStorage.getItem("usuario");
    console.log(usuarioRol);

    if (usuarioRol !== "Invitado") {

        $("#btnSesion").val("Cerrar Sesión");

        configuracionInicial();
        cargarLaboratoristas();
        cargarTablaLaboratorios();
        cargarCodigoDia();
        cargarNumeroPrestamo();
        cargarFecha();
        $("#btnGuardar").prop("disabled", true);
        $("#btnLimpiar").prop("disabled", true);

        $("#btnGuardar").click(function () {
            if (verificarCampos() === true) {
                insertarLaboratorioDocente();
            } else {
                alertify.error("Existen Campos Vacios. Verifique Por Favor");
            }
        });

        $("#btnLimpiar").click(function () {
            if (confirm("¿Está Seguro De Limpiar Los Campos?")) {
                limpiarCampos();
            }
        });

    } else {
        url = "Pagina_No_Autorizada.aspx";
        $(location).attr('href', url);
    }

    $("#btnSesion").click(function () {
        url = "Login_Sistema.aspx";
        $(location).attr('href', url);
    });

});

function insertarLaboratorioDocente() {
    var data = {
        fechaPrestamo: $("#txtFecha").val(),
        idLaboratorio: $("#txtCodigoLaboratorio").val(),
        cedulaLaboratorista: $("#txtCedulaLaboratorista").val(),
        idMateria: $("#txtCodigoMateria").val(),
        estadoPrestamo: "0"
    };
    $.ajax({
        type: "POST",
        url: "https://localhost:44315/api/LaboratoriosDocentes",
        data: JSON.stringify(data),
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
            alertify.success("Estudiante Insertado Correctamente");
            limpiarCampos();
            cargarTablaDatos();
        }
    });
}

function limpiarCampos() {
    cargarNumeroPrestamo();
    configuracionInicial();
    $("#tbl_Laboratorios").dataTable().fnClearTable();
    loadDataTable();
    $("#txtCedulaLaboratorista").val("");
    $("#txtNombreLaboratorista").val("");
    $("#txtNombreLaboratorio").val("");
    $("#txtTipoLaboratorio").val("");
    $("#txtNombreMateria").val("");
    $("#txtCargaHoraria").val("");
    $("#txtCedulaDocente").val("");
    $("#txtNombreDocente").val("");
    $("#btnGuardar").prop("disabled", true);
    $("#btnLimpiar").prop("disabled", true);
}

function cargarNumeroPrestamo() {

    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/values/prestamoLabDocente",
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
            $("#txtCodigo").val(data);
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

function configuracionInicial() {
    $("#btnBuscarLaboratorio").prop("disabled", true);
    $("#btnBuscarMateria").prop("disabled", true);
}

function verificarCampos() {
    if ($("#txtCedulaLaboratorista").val() === "") {
        $("#btnBuscarLaboratorista").focus();
        return false;
    } else if ($("#txtCodigoLaboratorio").val() === "") {
        $("#btnBuscarLaboratorio").focus();
        return false;
    } else if ($("#txtCodigoMateria").val() === "") {
        $("#btnBuscarMateria").focus();
        return false;
    }
    return true;
}

//Cargar Código Día
function cargarCodigoDia() {

    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/values/codigoDiaPrestamo",
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
            $("#txtCodigoDia").val(data);
        }
    });
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
        $("#txtNombreLaboratorista").val(datos);
        $("#btnBuscarLaboratorio").prop("disabled", false);
        $("#btnLimpiar").prop("disabled", false);
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

//Cargar Tabla Materias
function cargarTablaMaterias() {
    var table = $('#tbl_Materias').DataTable();
    table.clear();
    loadTableMaterias();
    table.column(0).visible(false);

    $('#tbl_Materias tbody').on('click', 'tr', function () {
        datosTabla = table.row(this).data();
        $('input[type=search]').val('').change();
        $(this).removeClass('selected');
        table.search('').draw();
        $("#txtCodigoMateria").val(datosTabla[0]);
        $("#txtNombreMateria").val(datosTabla[1]);
        $("#txtCedulaDocente").val(datosTabla[2]);
        var datos = datosTabla[3] + " " + datosTabla[4];
        $("#txtNombreDocente").val(datos);
        $("#txtCargaHoraria").val(datosTabla[5]);
        $("#btnGuardar").prop("disabled", false);
        $("#ModalMaterias").modal('toggle');
    });
}

function loadTableMaterias() {
    var idDia = $("#txtCodigoDia").val();
    var idLaboratorio = $("#txtCodigoLaboratorio").val();
    var _h = "hola";
    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/LaboratoriosDocentes?idDia=" + idDia + "&idLaboratorio=" + idLaboratorio,
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
            addRowMaterias(data);
        }
    });
}

function addRowMaterias(data) {
    try {
        var table = $("#tbl_Materias").dataTable();

        for (var i = 0; i < data.length; i++) {
            table.fnAddData([
                data[i].idMateria,
                data[i].nombreMateria,
                data[i].cedulaDocente,
                data[i].nombreDocente,
                data[i].apellidoDocente,
                data[i].horarioMateria
            ]);
        }

    } catch (e) {
        alertify.error(e)
    }
}

//Cargar Tabla Laboratorios
function cargarTablaLaboratorios() {
    var table = $('#tbl_Laboratorios').DataTable();
    table.clear();
    loadDataTable();
    table.column(0).visible(false);

    $('#tbl_Laboratorios tbody').on('click', 'tr', function () {
        datosTabla = table.row(this).data();
        $('input[type=search]').val('').change();
        $(this).removeClass('selected');
        table.search('').draw();
        $("#txtCodigoLaboratorio").val(datosTabla[0]);
        $("#txtNombreLaboratorio").val(datosTabla[1]);
        $("#txtTipoLaboratorio").val(datosTabla[3]);
        $("#btnBuscarMateria").prop("disabled", false);
        $("#ModalLaboratorio").modal('toggle');
        $("#tbl_Materias").dataTable().fnClearTable();
        cargarTablaMaterias();
    });
}

function loadDataTable() {
    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/Laboratorios/laboratorioLibres",
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

function addRowTable(data) {
    try {
        var table = $("#tbl_Laboratorios").dataTable();

        for (var i = 0; i < data.length; i++) {
            table.fnAddData([
                data[i].idLaboratorio,
                data[i].nombreLaboratorio,
                data[i].ubicacionLaboratorio,
                data[i].tipoLaboratorio
            ]);
        }

    } catch (e) {
        alertify.error(e)
    }
}