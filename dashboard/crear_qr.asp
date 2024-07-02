<!-- #include file="../includes/server/config.asp" -->
<!-- #include file="../includes/server/fnDB.asp" -->
<!-- #include file="../includes/server/qrcode.asp" -->
<%
    DisableCache()

    txtMensaje = ""
    txtError = "N"

    Set objConn = AbrirConnDB()

        strQuery = "Select * From Clientes Where QR_"
    
        set objRs = objConn.Execute( strQuery )
        if objConn.Errors.Count = 0 then 
        end if 
    end if 

    objRs.Close
    Set objRs = nothing    
    CerraConnDB( objConn )


%>