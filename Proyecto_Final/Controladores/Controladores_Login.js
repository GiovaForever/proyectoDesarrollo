$(document).ready(function () {

    limpiarCampos();
    $("#btnSesion").val("Iniciar Sesión");
    $("#txtCorreo").focus()
    var rolUsuario = localStorage.getItem("usuario");
    if (rolUsuario !== "Invitado") {
        localStorage.setItem("usuario", "Invitado");
    }
    $("#btnIngresar").click(function () {
        if (verificarCampos() === true) {
            verificarCredenciales();
        } else {
            alertify.error("Existen Campos Vacios.");
        }
    });

});

function verificarCampos() {
    if ($("#txtCorreo").val() === "") {
        $("#txtCorreo").focus();
        return false;
    } else if ($("#txtContrasenia").val() === "") {
        $("#txtContrasenia").focus();
        return false;
    }
    return true;
}

function verificarCredenciales() {
    var correo = $("#txtCorreo").val();
    var contrasenia = $("#txtContrasenia").val();
    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/Usuarios?correo=" + correo + "&contrasenia=" + contrasenia,
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
            if (data === "Invitado") {
                alertify.error("Credenciales Incorrectas....");
                $("#txtCorreo").focus();
            } else {
                localStorage.setItem("usuario", data);
                url = "Index.aspx";
                $(location).attr('href', url);
            }
        }
    });
}

function limpiarCampos() {
    $("#txtCorreo").val("");
    $("#txtContrasenia").val("");
    $("#txtCorreo").focus();
    localStorage.setItem("usuario", "Invitado");
}