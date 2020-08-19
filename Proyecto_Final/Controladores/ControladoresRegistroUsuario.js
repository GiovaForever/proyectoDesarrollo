$(document).ready(function () {
    limpiarCampos();
    $("#txtNombreCompleto").focus()
    $("#btnRegistrar").click(function () {
        if (verificarCampos() === true) {
            registrarNuevoUsuario();
        } else {
            alertify.error("Error Existen Campos Vacios");
        }
    });

    $("#btnSesion").click(function () {
        url = "Login_Sistema.aspx";
        $(location).attr('href', url);
    });
});

function registrarNuevoUsuario() {
    var data = {
        nombreCompletoUsuario: $("#txtNombreCompleto").val(),
        correoUsuario: $("#txtCorreo").val(),
        passwordUsuario: $("#txtContrasenia").val()
    };
    $.ajax({
        type: "POST",
        url: "https://localhost:44315/api/Usuarios",
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
            alert("Usuario Creado Correctamente");
            url = "Login_Sistema.aspx";
            $(location).attr('href', url);
        }
    });
}

function verificarCampos() {
    if ($("#txtNombreCompleto").val() === "") {
        $("#txtNombreCompleto").focus();
        return false;
    } else if ($("#txtCorreo").val() === "") {
        $("#txtCorreo").focus();
        return false;
    } else if ($("#txtContrasenia").val() === "") {
        $("#txtContrasenia").focus();
        return false;
    }
    return true;
}

function limpiarCampos() {
    $("#txtNombreCompleto").val("");
    $("#txtCorreo").val("");
    $("#txtContrasenia").val("");
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