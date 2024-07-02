<%

function Conexion()
    'Conexion = "DSN=CONTROL_EVENTOS_2024;UID=CONTROL_EVENTOS_2024;PWD=;APP=CONTROL DE EVENTOS - V1;WSID=" & Request.ServerVariables( "REMOTE_ADDR" ) & ";DATABASE=Eventos_Scanid"
    Conexion = "DSN=EV_Scanid;UID=EV_Scanid;PWD=2bvU^43z1;APP=CONTROL DE EVENTOS - V1;WSID=" & Request.ServerVariables( "REMOTE_ADDR" ) & ";DATABASE=Eventos_Scanid"
end function

function AbrirConnDB()

	SET objConn = Server.CreateObject("ADODB.Connection")
	objConn.Open Conexion()
	objConn.commandtimeout = 3600

    Set AbrirConnDB = objConn

end function

function CerraConnDB( objConn )

	objConn.Close()
	Set objConn = nothing

end function

%>