$(document).ready(function () {

    var usuarioRol = localStorage.getItem("usuario");
    console.log(usuarioRol);

    if (usuarioRol !== "Invitado") {

        if (usuarioRol !== "Admin") {
            url = "Pagina_No_Autorizada.aspx";
            $(location).attr('href', url);
        } else {
            configuracionInicial();
            cargarTablaDatos();

            $("#txtCedula").keyup(function () {
                var cantLetras = $("#txtCedula").val().length;
                if (cantLetras !== 0) {
                    $("#btnGuardar").prop("disabled", false);
                    $("#btnLimpiar").prop("disabled", false);
                } else {
                    $("#btnGuardar").prop("disabled", true);
                    $("#btnLimpiar").prop("disabled", true);
                }
            });

            $("#txtCedula").blur(function () {
                var cantLetras = $("#txtCedula").val().length;
                if (cantLetras < 10) {
                    $("#btnGuardar").prop("disabled", true);
                    $("#btnLimpiar").prop("disabled", true);
                } else {
                    var result = verificarCedula($("#txtCedula").val());
                    if (result == false) {
                        alertify.error("Número De Cédula Erróneo");
                        $('#txtCedula').focus();
                    }
                }
            });

            $("#btnLimpiar").click(function () {
                limpiarCampos();
            });

            $("#btnEliminar").click(function () {
                if (confirm('¿Esta Seguro De Eliminar?')) {
                    eliminarLaboratorista();
                }
            });

            $("#btnGuardar").click(function () {
                var actualizar = $("#txtCedula").prop("disabled");

                if (ValidarCampos() === true) {
                    if (actualizar === true) {
                        actualizarLaboratorista();
                    } else {
                        insertarLaboratorista();
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

function actualizarLaboratorista() {
    var data = {
        cedulaLaboratorista: $("#txtCedula").val(),
        nombreLaboratorista: $("#txtNombre").val(),
        apellidoLaboratorista: $("#txtApellido").val(),
        telefonoLaboratorista: $("#txtTelefono").val()
    };
    $.ajax({
        type: "PUT",
        url: "https://localhost:44315/api/Laboratoristas",
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
            alertify.success("Laboratorista Modificado Correctamente");
            limpiarCampos();
            cargarTablaDatos();
        }
    });
}

function eliminarLaboratorista() {
    $.ajax({
        type: "DELETE",
        url: "https://localhost:44315/api/Laboratoristas",
        data: $("#txtCedula").val(),
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
            alertify.success("Laboratorista Eliminado Correctamente");
            limpiarCampos();
            cargarTablaDatos();
        }
    });
}

function insertarLaboratorista() {
    var data = {
        cedulaLaboratorista: $("#txtCedula").val(),
        nombreLaboratorista: $("#txtNombre").val(),
        apellidoLaboratorista: $("#txtApellido").val(),
        telefonoLaboratorista: $("#txtTelefono").val()
    };
    $.ajax({
        type: "POST",
        url: "https://localhost:44315/api/Laboratoristas",
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
            alertify.success("Laboratorista Insertado Correctamente");
            limpiarCampos();
            cargarTablaDatos();
        }
    });
}

function configuracionInicial() {
    $("#btnGuardar").prop("disabled", true);
    $("#btnLimpiar").prop("disabled", true);
    $("#btnEliminar").prop("disabled", true);
    $("#txtCedula").focus();
}

function cargarTablaDatos() {

    var table = $('#tbl_Laboratoristas').DataTable();
    table.clear();
    loadDataTable();

    $('#tbl_Laboratoristas tbody').on('click', 'tr', function () {
        datosTabla = table.row(this).data();
        cargarCamposGrid(datosTabla);
        $('input[type=search]').val('').change();
        $(this).removeClass('selected');
        table.search('').draw();
    });

}

function cargarCamposGrid(data) {
    $("#txtCedula").val(data[0]);
    $("#txtNombre").val(data[1]);
    $("#txtApellido").val(data[2]);
    $("#txtTelefono").val(data[3]);
    $("#txtCedula").prop("disabled", true);
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
            addRowTable(data);
        }
    });
}

function addRowTable(data) {
    try {
        var table = $("#tbl_Laboratoristas").dataTable();

        for (var i = 0; i < data.length; i++) {
            table.fnAddData([
                data[i].cedulaLaboratorista,
                data[i].nombreLaboratorista,
                data[i].apellidoLaboratorista,
                data[i].telefonoLaboratorista,
            ]);
        }

    } catch (e) {
        alertify.error(e)
    }
}

function verificarCedula(cedula) {
    if (cedula.length == 10) {
        var digito_region = cedula.substring(0, 2);
        if (digito_region >= 1 && digito_region <= 24) {
            var ultimo_digito = cedula.substring(9, 10);
            var pares = parseInt(cedula.substring(1, 2)) + parseInt(cedula.substring(3, 4)) + parseInt(cedula.substring(5, 6)) + parseInt(cedula.substring(7, 8));

            var numero1 = cedula.substring(0, 1);
            var numero1 = (numero1 * 2);
            if (numero1 > 9) { var numero1 = (numero1 - 9); }

            var numero3 = cedula.substring(2, 3);
            var numero3 = (numero3 * 2);
            if (numero3 > 9) { var numero3 = (numero3 - 9); }

            var numero5 = cedula.substring(4, 5);
            var numero5 = (numero5 * 2);
            if (numero5 > 9) { var numero5 = (numero5 - 9); }

            var numero7 = cedula.substring(6, 7);
            var numero7 = (numero7 * 2);
            if (numero7 > 9) { var numero7 = (numero7 - 9); }

            var numero9 = cedula.substring(8, 9);
            var numero9 = (numero9 * 2);
            if (numero9 > 9) { var numero9 = (numero9 - 9); }

            var impares = numero1 + numero3 + numero5 + numero7 + numero9;

            var suma_total = (pares + impares);

            var primer_digito_suma = String(suma_total).substring(0, 1);

            var decena = (parseInt(primer_digito_suma) + 1) * 10;

            var digito_validador = decena - suma_total;

            if (digito_validador == 10)
                var digito_validador = 0;

            if (digito_validador != ultimo_digito) {
                return false;
            } else {
                return true;
            }

        } else {
            return false;
        }
    } else {
        return false;
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

function limpiarCampos() {
    $("#txtCedula").val("");
    $("#txtCedula").prop("disabled", false);
    $("#txtNombre").val("");
    $("#txtApellido").val("");
    $("#txtTelefono").val("");
    $("#txtCedula").focus();
    configuracionInicial();
}

function ValidarCampos() {
    if ($("#txtNombre").val() === "") {
        $("#txtNombre").focus();
        return false;
    } else if ($("#txtApellido").val() === "") {
        $("#txtApellido").focus();
        return false;
    } else if ($("#txtTelefono").val() === "") {
        $("#txtTelefono").focus();
        return false;
    }
    return true;
}