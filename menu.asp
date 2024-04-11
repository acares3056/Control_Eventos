<!-- #include file="includes/server/valida_acceso_paginas.asp" -->
<!-- #include file="includes/server/fnDB.asp" -->
<% 
    if Acceso_Pagina = false then
    
        response.clear
        response.redirect ( "Sin_acceso.html" )
        response.end

    end if

	Set Conn = AbrirConnDB()

    strQuery = "Execute FXP_Lista_opciones_asignadas_a_usuario '" & Session("scanid_Login") & "'"
    Set Rs = Conn.Execute ( strQuery )
    If Rs.Eof then
        response.clear
        response.redirect ( "Sin_asignacion.html" )
        response.end
    End if

    'CerraConnDB( Conn )

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>BACKEND - SCANID</title>

    <link rel="apple-touch-icon" type="image/png" href="https://cpwebassets.codepen.io/assets/favicon/apple-touch-icon-5ae1a0698dcc2402e9712f7d01ed509a57814f994c660df9f7a952f3060705ee.png" />

    <meta name="apple-mobile-web-app-title" content="CodePen">

    <link rel="shortcut icon" type="image/x-icon" href="https://cpwebassets.codepen.io/assets/favicon/favicon-aec34940fbc1a6e787974dcd360f2c6b63348d4b1f4e06c77743096d55480f33.ico" />

    <link rel="mask-icon" type="image/x-icon" href="https://cpwebassets.codepen.io/assets/favicon/logo-pin-b4b4269c16397ad2f0f7a01bcdf513a1994f4c94b8af2f191c09eb0d601762b1.svg" color="#111" />
  
    <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css'>

    <link rel='stylesheet' href='css/menu.css'>
</head>

<body translate="no">
  <nav class="navbar navbar-expand-md navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">
      <img class="logo horizontal-logo" src="images/logo_scanid.png" alt="ScanId logo">
      </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav ml-auto">
<% Do While Not Rs.Eof 
      Modulo = Rs("Modulo")
      Grupo = Rs("Grupo")
      %>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown2" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><%=Rs("Grupo")%></a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdown2">
            <% Do While Grupo = Rs("Grupo") %>
                <a class="dropdown-item" href="#" onclick="javascript:fnCargaOpcion('<%=rs("opcion")%>')"><%=Rs("Nombre_opcion")%></a>
            <!-- <div class="dropdown-divider"></div> -->
            <%    Rs.MoveNext
                  if Rs.Eof then 
                    exit do
                  end if
              Loop %>
          </div>
        </li>
<%  if Rs.Eof then
      exit do
    end if  
  Loop %>
        <li class="nav-item">
          <a class="nav-link" href="#" onclick="javascript:fnInicio();">LogOut</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<section>
  <div id="trabajo"></div>
</section>

<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/js/bootstrap.min.js'></script>
<script id="rendered-js" >
const $dropdown = $(".dropdown");
const $dropdownToggle = $(".dropdown-toggle");
const $dropdownMenu = $(".dropdown-menu");
const showClass = "show";

$(window).on("load resize", function () {
  if (this.matchMedia("(min-width: 768px)").matches) {
    $dropdown.hover(
    function () {
      const $this = $(this);
      $this.addClass(showClass);
      $this.find($dropdownToggle).attr("aria-expanded", "true");
      $this.find($dropdownMenu).addClass(showClass);
    },
    function () {
      const $this = $(this);
      $this.removeClass(showClass);
      $this.find($dropdownToggle).attr("aria-expanded", "false");
      $this.find($dropdownMenu).removeClass(showClass);
    });

  } else {
    $dropdown.off("mouseenter mouseleave");
  }
});

    function fnCargaOpcion( opc ){
        $("#trabajo").html( opc );
    }

    function fnInicio(){
        location.href = "default.asp?v=" + Math.random();
    }
</script>

  
</body>

</html>
