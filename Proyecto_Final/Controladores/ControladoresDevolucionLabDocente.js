$(document).ready(function () {

    var usuarioRol = localStorage.getItem("usuario");
    console.log(usuarioRol);

    if (usuarioRol !== "Invitado") {

        $("#btnSesion").val("Cerrar Sesión");

        cargarCodigoDia();
        $("#btnGuardar").prop("disabled", true);
        $("#btnLimpiar").prop("disabled", true);
        $("#btnGuardar").click(function () {
            if (confirm("Está Seguro De Realizar La Transacción") === true) {
                devolverLaboratorio();
            }
        });

        $("#btnLimpiar").click(function () {
            if (confirm("¿Está Seguro De Limpiar Los Campos?")) {
                limpiarCampos();
                $("#tbl_Prestamos").dataTable().fnClearTable();
                loadDataTable();
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

function devolverLaboratorio() {

    $.ajax({
        type: "PUT",
        url: "https://localhost:44315/api/LaboratoriosDocentes?idLaboratorio=" + $("#txtCodigo").val(),
        data: {},
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
            alertify.success("Devolución Realizada Correctamente");
            limpiarCampos();
            $("#tbl_Prestamos").dataTable().fnClearTable();
            loadDataTable();
        }
    });
}

function limpiarCampos() {
    $("#txtCodigo").val("");
    $("#txtFecha").val("");
    $("#txtNombreLaboratorista").val("");
    $("#txtNombreLaboratorio").val("");
    $("#txtTipoLaboratorio").val("");
    $("#txtNombreMateria").val("");
    $("#txtNombreDocente").val("");
    $("#txtCargaHoraria").val("");
    $("#btnGuardar").prop("disabled", true);
    $("#btnLimpiar").prop("disabled", true);
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
            cargarTablaDatos(data);
        }
    });
}

function cargarTablaDatos(data) {
    var table = $('#tbl_Prestamos').DataTable();
    table.clear();
    table.column(0).visible(false);
    table.column(1).visible(false);
    table.column(2).visible(false);
    table.column(3).visible(false);
    table.column(6).visible(false);
    loadDataTable(data);

    $('#tbl_Prestamos tbody').on('click', 'tr', function () {
        datosTabla = table.row(this).data();
        $('input[type=search]').val('').change();
        $(this).removeClass('selected');
        table.search('').draw();
        $("#txtCodigo").val(datosTabla[0]);
        $("#txtFecha").val(datosTabla[1]);
        $("#txtNombreLaboratorista").val(datosTabla[2]);
        $("#txtNombreLaboratorio").val(datosTabla[4]);
        $("#txtTipoLaboratorio").val(datosTabla[5]);
        $("#txtNombreMateria").val(datosTabla[7]);
        $("#txtNombreDocente").val(datosTabla[8]);
        $("#txtCargaHoraria").val(datosTabla[9]);
        $("#btnGuardar").prop("disabled", false);
        $("#btnLimpiar").prop("disabled", false);
        $("#ModalPrestamos").modal('toggle');
        $("#btnGuardar").prop("disabled", false);
    });

}

function loadDataTable(data) {
    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/LaboratoriosDocentes/laboratoriosOcupados?idDia=" + data,
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
        var table = $("#tbl_Prestamos").dataTable();

        for (var i = 0; i < data.length; i++) {
            table.fnAddData([
                data[i].idLabDocente,
                data[i].fechaPrestamo,
                data[i].nombreLaboratorista + " " + data[i].apellidoLaboratorista,
                data[i].idLaboratorio,
                data[i].nombreLaboratorio,
                data[i].nombreTipoLaboratorio,
                data[i].idMateria,
                data[i].nombreMateria,
                data[i].nombreDocente + " " + data[i].apellidoDocente,
                data[i].horario
            ]);
        }

    } catch (e) {
        alertify.error(e)
    }
}