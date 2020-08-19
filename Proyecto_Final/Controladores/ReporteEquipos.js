$(document).ready(function () {

    $("#cmbTipoLaboratorio").change(function () {
        if ($("#cmbTipoLaboratorio").val() !== "-1") {
            var tipo = $("#cmbTipoLaboratorio").val();
            obtenerLaboratorios(tipo);
        }
    });

    $("#cmbLaboratorio").change(function () {
        if ($("#cmbLaboratorio").val() !== "-1") {
            var tipo = $("#cmbLaboratorio").val();
            $("#txt1").val(tipo);
        }
    });
    obtenerCategorias();
    obtenerTipoLaboratorios();

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

    function configuracionInicial() {
        $("#btnGuardar").prop("disabled", true);
        $("#btnLimpiar").prop("disabled", true);
        $("#btnEliminar").prop("disabled", true);
        $("#txtCedula").focus();
    }

    $("#txtNombre").keyup(function () {
        var cantLetras = $("#txtNombre").val().length;
        if (cantLetras !== 0) {
            $("#btnGuardar").prop("disabled", false);
            $("#btnLimpiar").prop("disabled", false);
        } else {
            $("#btnGuardar").prop("disabled", true);
            $("#btnLimpiar").prop("disabled", true);
        }
    });

    $("#btnLimpiar").click(function () {
        limpiarCampos();
    });

    $("#btnEliminar").click(function () {
        if (confirm('¿Esta Seguro De Eliminar?')) {
            eliminarLaboratorio();
        }
    });

    $("#btnGuardar").click(function () {
        var actualizar = $("#txtId").prop("disabled");

        if (validarCampos() === true) {
            if (actualizar === true) {
                actualizarLaboratorio();
            } else {
                insertarLaboratorio();
            }
        } else {
            alertify.error("Existen Campos Vacios. Verifique Por favor.");
        }

    });

});

function eliminarLaboratorio() {
    $.ajax({
        type: "DELETE",
        url: "https://localhost:44315/api/Laboratorios",
        data: $("#txtId").val(),
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
            alertify.success("Laboratorio Eliminado Correctamente");
            limpiarCampos();
            cargarTablaDatos();
        }
    });
}

function actualizarLaboratorio() {
    var data = {
        idLaboratorio: $("#txtId").val(),
        nombreLaboratorio: $("#txtNombre").val(),
        ubicacionLaboratorio: $("#txtUbicacion").val(),
        capacidadLaboratorio: $("#txtCapacidad").val(),
        tipoLaboratorio: $("#cmbTipoLaboratorio").val(),
        estadoLaboratorio: $("#cmbEstado").val(),
    };
    $.ajax({
        type: "PUT",
        url: "https://localhost:44315/api/Laboratorios",
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
            alertify.success("Laboratorio Modificado Correctamente");
            limpiarCampos();
            cargarTablaDatos();
        }
    });
}

function insertarLaboratorio() {
    var data = {
        idLaboratorio: "0",
        nombreLaboratorio: $("#txtNombre").val(),
        ubicacionLaboratorio: $("#txtUbicacion").val(),
        capacidadLaboratorio: $("#txtCapacidad").val(),
        tipoLaboratorio: $("#cmbTipoLaboratorio").val(),
        estadoLaboratorio: $("#cmbEstado").val(),
    };
    $.ajax({
        type: "POST",
        url: "https://localhost:44315/api/Laboratorios",
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
            alertify.success("Laboratorio Insertado Correctamente");
            limpiarCampos();
            cargarTablaDatos();
        }
    });
}

function validarCampos() {
    if ($("#txtNombre").val() === "") {
        $("#txtNombre").focus();
        return false;
    } else if ($("#txtUbicacion").val() === "") {
        $("#txtUbicacion").focus();
        return false;
    } else if ($("#txtCapacidad").val() === "") {
        $("#txtCapacidad").focus();
        return false;
    } else if ($("#cmbTipoLaboratorio").val() === "-1") {
        $("#cmbTipoLaboratorio").focus();
        return false;
    } else if ($("#cmbEstado").val() === "-1") {
        $("#cmbEstado").focus();
        return false;
    }
    return true;
}

function limpiarCampos() {
    $("#txtNombre").val("");
    $("#txtCapacidad").val("");
    $("#txtUbicacion").val("");
    $("#cmbTipoLaboratorio").val("-1");
    $("#cmbEstado").val("-1");
    $("#txtId").prop("disabled", false);
    configuracionInicial();
}

function obtenerTipoLaboratorios() {
    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/TipoLaboratorios",
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
            cargarTipoLaboratorios(data);
        }
    });
}

function cargarTipoLaboratorios(data) {
    var html_code = '<option value="-1">---Seleccione---</option>';
    $.each(data, function (key, value) {
        html_code += '<option value="' + value.idTipoLaboratorio + '">' + value.nombreTipoLaboratorio + '</option>';
    });
    $("#cmbTipoLaboratorio").html(html_code);
}
function obtenerLaboratorios(tipo) {
    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/Laboratiorios/LaboratoriosbyId?id=" + tipo,
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
            cargarLaboratorios(data);
        }
    });
}
function cargarLaboratorios(data) {
    var html_code = '<option value="-1">---Seleccione---</option>';
    $.each(data, function (key, value) {
        html_code += '<option value="' + value.idLaboratorio + '">' + value.nombreLaboratorio + '</option>';
    });
    $("#cmbLaboratorio").html(html_code);
}


function obtenerIdTipoLaboratorio(nombreTipo) {
    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/TipoLaboratorios?nombre=" + nombreTipo,
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
            $("#cmbTipoLaboratorio").val(data.idTipoLaboratorio);
        }
    });
}

