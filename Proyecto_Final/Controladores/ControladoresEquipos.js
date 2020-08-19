$(document).ready(function () {

    var usuarioRol = localStorage.getItem("usuario");
    console.log(usuarioRol);

    if (usuarioRol !== "Invitado") {

        $("#btnSesion").val("Cerrar Sesión");
        $("#btnSesion").removeClass();
        $("#btnSesion").addClass("btn btn-danger");

        if (usuarioRol !== "Admin") {
            url = "Pagina_No_Autorizada.aspx";
            $(location).attr('href', url);
        } else {
            limpiarCampos();
            var path = "";
            cargarTablaLaboratorios();

            $('input[type=file]').change(function (event) {
                var tmppath = URL.createObjectURL(event.target.files[0]);
                $(".upload-msg").text('Cargando...');
                path = tmppath;
            })

            $("#btnGuardar").click(function () {
                if ($("#txtNombre").val() !== "") {
                    if (path !== "") {
                        convertExcelJson(path);
                    } else {
                        alertify.error("Existen Campos Vacios. Verifique, por favor.");
                        $("#customFile").focus();
                    }
                } else {
                    alertify.error("Existen Campos Vacios. Verifique, por favor.");
                    $("#btnBuscarLaboratorista").focus();
                }
            });

            $(".custom-file-input").on("change", function (event) {
                var fileName = $(this).val().split("\\").pop();
                $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
                var tmppath = URL.createObjectURL(event.target.files[0]);
                path = tmppath;
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
        $("#txtCodigo").val(datosTabla[0]);
        $("#txtNombre").val(datosTabla[1]);
        $("#txtUbicacion").val(datosTabla[2]);
        $("#txtTipoLaboratorio").val(datosTabla[3]);
        $("#ModalLaboratorio").modal('toggle');
    });
}

function loadDataTable() {
    $.ajax({
        type: "GET",
        url: "https://localhost:44315/api/Laboratorios/detalleLaboratorio",
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
                data[i].nombreTipoLaboratorio
            ]);
        }

    } catch (e) {
        alertify.error(e)
    }
}

function convertExcelJson(archivo) {

    var url = archivo;
    var json = "";
    var oReq = new XMLHttpRequest();
    oReq.open("GET", url, true);
    oReq.responseType = "arraybuffer";

    oReq.onload = function (e) {
        var arraybuffer = oReq.response;

        var data = new Uint8Array(arraybuffer);
        var arr = new Array();
        for (var i = 0; i != data.length; ++i) arr[i] = String.fromCharCode(data[i]);
        var bstr = arr.join("");

        var workbook = XLSX.read(bstr, { type: "binary" });

        var first_sheet_name = workbook.SheetNames[0];

        var worksheet = workbook.Sheets[first_sheet_name];

        json = XLSX.utils.sheet_to_json(worksheet, { raw: true });

        registrarHorario(json);
    }
    oReq.send();

}

function registrarHorario(json) {

    var jsonFormat = generarJsonHorario(json);

    $.ajax({
        type: "POST",
        url: "https://localhost:44315/api/Horarios/Equipos",
        data: jsonFormat,
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
            alertify.success("Equipos Registrados Correctamente");
            limpiarCampos();
        }
    });

}

function generarJsonHorario(json) {

    jsonFormat = "{\"idLaboratorio\":\"" + $("#txtCodigo").val() + "\",\"lstEquipos\":["
    for (var i = 0; i < json.length; i++) {

        var fila = json[i]

        jsonFormat += "[";
        jsonFormat += "\"" + fila["Equipo"] + "\",";
        jsonFormat += "\"" + fila["Descripción"] + "\"";
        jsonFormat += "],";
    }

    jsonFormat = jsonFormat.substring(0, jsonFormat.length - 1);

    jsonFormat += "]}"

    return jsonFormat;
}

function limpiarCampos() {
    $("#txtCodigo").val("");
    $("#txtNombre").val("");
    $("#txtTipoLaboratorio").val("");
    $("#txtUbicacion").val("");
    $("#btnBuscarLaboratorista").focus();
}