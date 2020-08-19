$(document).ready(function () {

    var usuarioRol = localStorage.getItem("usuario");
    console.log(usuarioRol);

    if (usuarioRol !== "Invitado") {

        if (usuarioRol !== "Admin") {
            url = "Pagina_No_Autorizada.aspx";
            $(location).attr('href', url);
        } else {
            obtenerCarreras();
            configuracionInicial();
            //Materias
            cargarTablaDatos();
            //Docentes
            cargarTablaDocentes();

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
                    eliminarMateria();
                }
            });

            $("#btnGuardar").click(function () {
                var actualizar = $("#txtId").prop("disabled");

                if (validarCampos() === true) {
                    if (actualizar === true) {
                        actualizarMateria();
                    } else {
                        insertarMateria();
                    }
                } else {
                    alertify.error("Existen Campos Vacios. Verifique Por favor.");
                }

            });
        }
    } else {
        url = "Pagina_No_Autorizada.aspx";
        $(location).attr('href', url);
    }

    $("#btnSesion").click(function () {
        url = "Login_Sistema.aspx";
        $(location).attr('href', url);
    });

});

function eliminarMateria() {
    $.ajax({
        type: "DELETE",
        url: "https://localhost:44315/api/Materias",
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
            alertify.success("Materia Eliminada Correctamente");
            limpiarCampos();
            cargarTablaDatos();
        }
    });
}

function actualizarMateria() {
    var data = {
        idMateria: $("#txtId").val(),
        nombreMateria: $("#txtNombre").val(),
        cedulaDocente: $("#txtCedula").val(),
        nivelMateria: $("#txtNivel").val(),
        idCarrera: $("#cmbCarrera").val()
    };
    $.ajax({
        type: "PUT",
        url: "https://localhost:44315/api/Materias",
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
            alertify.success("Materia Modificada Correctamente");
            limpiarCampos();
            cargarTablaDatos();
        }
    });
}

function insertarMateria() {
    var data = {
        idMateria: "0",
        nombreMateria: $("#txtNombre").val(),
        cedulaDocente: $("#txtCedula").val(),
        nivelMateria: $("#txtNivel").val(),
        idCarrera: $("#cmbCarrera").val()
    };
    $.ajax({
        type: "POST",
        url: "https://localhost:44315/api/Materias",
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
            alertify.success("Materia Insertada Correctamente");
            limpiarCampos();
            cargarTablaDatos();
        }
    });
}

function validarCampos() {
    if ($("#txtNombre").val() === "") {
        $("#txtNombre").focus();
        return false;
    } else if ($("#txtNivel").val() === "") {
        $("#txtNivel").focus();
        return false;
    } else if ($("#cmbCarrera").val() === "-1") {
        $("#cmbCarrera").focus();
        return false;
    } else if ($("#txtCedula").val() === "") {
        $("#txtCedula").focus();
        return false;
    }
    return true;
}

function limpiarCampos() {

    $("#txtId").val("");
    $("#txtNombre").val("");
    $("#txtCedula").val("");
    $("#txtDatos").val("");
    $("#txtNivel").val("");
    $("#cmbCarrera").val("-1");
    $("#txtId").prop("disabled", false);
    configuracionInicial();
}

function obtenerCarreras() {
    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/Carreras",
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
            cargarCarreras(data)
        }
    });
}

function cargarCarreras(data) {
    var html_code = '<option value="-1">---Seleccione---</option>';
    $.each(data, function (key, value) {
        html_code += '<option value="' + value.idCarrera + '">' + value.nombreCarrera + '</option>';
    });
    $("#cmbCarrera").html(html_code);
}

function configuracionInicial() {
    $("#btnGuardar").prop("disabled", true);
    $("#btnLimpiar").prop("disabled", true);
    $("#btnEliminar").prop("disabled", true);
    $("#txtCedula").focus();
}

function cargarTablaDatos() {

    var table = $('#tbl_Materias').DataTable();
    table.clear();
    loadDataTable();
    table.column(0).visible(false);
    table.column(2).visible(false);
    table.column(5).visible(false);

    $('#tbl_Materias tbody').on('click', 'tr', function () {
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
    $("#txtCedula").val(data[2]);
    $("#txtDatos").val(data[3]);
    $("#txtNivel").val(data[4]);
    $("#cmbCarrera").val(data[5]);
    botonesClicTable();
    $('#txtNombre').focus();
}

function botonesClicTable() {
    $("#btnGuardar").prop("disabled", false);
    $("#btnLimpiar").prop("disabled", false);
    $("#btnEliminar").prop("disabled", false);
}

function loadDataTable() {
    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/Materias",
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
        var table = $("#tbl_Materias").dataTable();

        for (var i = 0; i < data.length; i++) {
            table.fnAddData([
                data[i].idMateria,
                data[i].nombreMateria,
                data[i].cedulaDocente,
                data[i].nombreDocente + " " + data[i].apellidoDocente,
                data[i].nivelMateria,
                data[i].idCarrera,
                data[i].nombreCarrera
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

//Código Cargar Docentes
function cargarTablaDocentes() {

    var table = $('#tbl_Docentes').DataTable();
    table.clear();
    loadDataDocentes();

    $('#tbl_Docentes tbody').on('click', 'tr', function () {
        datosTabla = table.row(this).data();
        $('input[type=search]').val('').change();
        $(this).removeClass('selected');
        table.search('').draw();
        $("#txtCedula").val(datosTabla[0]);
        var datos = datosTabla[1] + " " + datosTabla[2];
        $("#txtDatos").val(datos);
        $("#exampleModal").modal('toggle');
    });

}

function loadDataDocentes() {
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
            addRowTableDocentes(data);
        }
    });
}

function addRowTableDocentes(data) {
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