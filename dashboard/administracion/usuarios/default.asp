<!-- #include file="../../includes/server/config.asp" -->
<%
    Session.Abandon()

    SetLCID()

    Response.Redirect ( "login.asp" )
%>