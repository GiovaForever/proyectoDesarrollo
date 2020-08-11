$(document).ready(function () {

    obtenerTipoLaboratorios();
    configuracionInicial();
    cargarTablaDatos();

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
            cargarTipoLaboratorios(data)
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

function configuracionInicial() {
    $("#btnGuardar").prop("disabled", true);
    $("#btnLimpiar").prop("disabled", true);
    $("#btnEliminar").prop("disabled", true);
    $("#txtCedula").focus();
}

function cargarTablaDatos() {

    var table = $('#tbl_Laboratorios').DataTable();
    table.clear();
    loadDataTable();
    table.column(0).visible(false);

    $('#tbl_Laboratorios tbody').on('click', 'tr', function () {
        datosTabla = table.row(this).data();
        cargarCamposGrid(datosTabla);
        $('input[type=search]').val('').change();
        $(this).removeClass('selected');
        table.search('').draw();
    });

}

function cargarCamposGrid(data) {
    $("#txtId").val(data[0]);
    $("#txtId").prop("disabled", true);
    $("#txtNombre").val(data[1]);
    $("#txtUbicacion").val(data[2]);
    $("#txtCapacidad").val(data[3]);
    obtenerIdTipoLaboratorio(data[4])
    var codigo;
    if (data[5] === "Libre") {
        codigo = 0;
    } else {
        codigo = 1;
    }
    $("#cmbEstado").val(codigo);
    botonesClicTable();
    $('#txtNombre').focus();
}

function obtenerIdTipoLaboratorio(nombreTipo) {
    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/TipoLaboratorios?nombre="+nombreTipo,
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

function botonesClicTable() {
    $("#btnGuardar").prop("disabled", false);
    $("#btnLimpiar").prop("disabled", false);
    $("#btnEliminar").prop("disabled", false);
}

function loadDataTable() {
    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/Laboratorios",
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
                data[i].capacidadLaboratorio,
                data[i].tipoLaboratorio,
                data[i].estadoLaboratorio
            ]);
        }

    } catch (e) {
        alertify.error(e)
    }
}

function isNumber(character) {
    key = character.keyCode || character.which;
    tecla = String.fromCharCode(key);
    numeros = "0123456789";
    var especiales = [8, 127];
    tecla_especial = false;
    for (var i in especiales) {

        if (key == especiales[i]) {
            tecla_especial = true;
        }
    }
    if (numeros.indexOf(tecla) == -1 && !tecla_especial) {
        character.preventDefault();
    }
}

function isLetter(character) {
    key = character.keyCode || character.which;
    tecla = String.fromCharCode(key);
    numeros = "abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZÁÉÍÓÚáéíóúüÜ ";
    var especiales = [8, 127, 46];
    tecla_especial = false;
    for (var i in especiales) {

        if (key == especiales[i]) {
            tecla_especial = true;
        }
    }
    if (numeros.indexOf(tecla) == -1 && !tecla_especial) {
        character.preventDefault();
    }
}