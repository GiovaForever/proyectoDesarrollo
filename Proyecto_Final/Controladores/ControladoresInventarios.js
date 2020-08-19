$(document).ready(function () {

    var usuarioRol = localStorage.getItem("usuario");
    console.log(usuarioRol);

    if (usuarioRol !== "Invitado") {

        $("#btnSesion").val("Cerrar Sesión");

        if (usuarioRol !== "Admin") {
            url = "Pagina_No_Autorizada.aspx";
            $(location).attr('href', url);
        } else {
            obtenerCategorias();
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
                    eliminarInventario();
                }
            });

            $("#btnGuardar").click(function () {
                var actualizar = $("#txtId").prop("disabled");

                if (validarCampos() === true) {
                    if (actualizar === true) {
                        actualizarInventario();
                    } else {
                        insertarInventario();
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

function eliminarInventario() {
    $.ajax({
        type: "DELETE",
        url: "https://localhost:44315/api/Inventarios",
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
            alertify.success("Inventario Eliminado Correctamente");
            limpiarCampos();
            cargarTablaDatos();
        }
    });
}

function actualizarInventario() {
    var data = {
        idInventario: $("#txtId").val(),
        nombreInventario: $("#txtNombre").val(),
        cantidadInventario: $("#txtCantidad").val(),
        idCategoria: $("#cmbCategoria").val()
    };
    $.ajax({
        type: "PUT",
        url: "https://localhost:44315/api/Inventarios",
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
            alertify.success("Inventario Modificado Correctamente");
            limpiarCampos();
            cargarTablaDatos();
        }
    });
}

function insertarInventario() {
    var data = {
        idInventario: "0",
        nombreInventario: $("#txtNombre").val(),
        cantidadInventario: $("#txtCantidad").val(),
        idCategoria: $("#cmbCategoria").val()
    };
    $.ajax({
        type: "POST",
        url: "https://localhost:44315/api/Inventarios",
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
            alertify.success("Inventario Insertada Correctamente");
            limpiarCampos();
            cargarTablaDatos();
        }
    });
}

function validarCampos() {
    if ($("#txtNombre").val() === "") {
        $("#txtNombre").focus();
        return false;
    } else if ($("#cmbCategoria").val() === "-1") {
        $("#cmbCategoria").focus();
        return false;
    } else if ($("#txtCantidad").val() === "" || $("#txtCantidad").val() === "0") {
        $("#txtCantidad").focus();
        return false;
    }
    return true;
}

function limpiarCampos() {

    $("#txtId").val("");
    $("#txtNombre").val("");
    $("#txtCantidad").val("");
    $("#cmbCategoria").val("-1");
    $("#txtId").prop("disabled", false);
    configuracionInicial();
}

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

function cargarTablaDatos() {

    var table = $('#tbl_Inventarios').DataTable();
    table.clear();
    loadDataTable();
    table.column(0).visible(false);
    table.column(3).visible(false);

    $('#tbl_Inventarios tbody').on('click', 'tr', function () {
        datosTabla = table.row(this).data();
        cargarCamposGrid(datosTabla);
        $('input[type=search]').val('').change();
        $(this).removeClass('selected');
        table.search('').draw();
    });

}

function cargarCamposGrid(data) {
    console.log(data);
    $("#txtId").val(data[0]);
    $("#txtId").prop("disabled", true);
    $("#txtNombre").val(data[1]);
    $("#txtCantidad").val(data[2]);
    $("#cmbCategoria").val(data[3]);
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
            addRowTable(data);
        }
    });
}

function addRowTable(data) {
    try {
        var table = $("#tbl_Inventarios").dataTable();

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