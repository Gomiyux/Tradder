<%-- 
    Document   : alta
    Created on : 15-ene-2017, 20:19:11
    Author     : SebaL
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>DAW</title>
        <!-- BOOTSTRAP STYLES-->
        <link href="/COQUEBA/assets/css/bootstrap.css" rel="stylesheet" />
        <!-- FONTAWESOME STYLES-->
        <link href="/COQUEBA/assets/css/font-awesome.css" rel="stylesheet" />
        <!-- CUSTOM STYLES-->
        <link href="/COQUEBA/assets/css/custom.css" rel="stylesheet" />
        <!-- GOOGLE FONTS-->
        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
        <link href="https://fonts.googleapis.com/css?family=Vampiro+One" rel="stylesheet">
            <link href="https://fonts.googleapis.com/css?family=Chewy" rel="stylesheet">


                </head>
                <body>
                    <div id="wrapper">
                        <nav class="navbar navbar-default navbar-cls-top " role="navigation" style="margin-bottom: 0">
                            <div class="navbar-header">
                                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                                    <span class="sr-only">Toggle navigation</span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                                <a class="navbar-brand" style="padding-top: -10px;font-family: 'Vampiro One', cursive; font-size: 3em; color: #white;" href="/COQUEBA/controlador/home">TR</a> 
                            </div>

                            <c:if test="${sessionScope.user==null}">

                                <div class="content-fluid " id="login">

                                    <form class="row" role="form"  action="/COQUEBA/controlador/validar">
                                        <div class="col-md-6"></div>  
                                        <div class="col-md-4" style="color: black ;display: inline; margin-top: 1%;">
                                            <i style="color: white;" class="glyphicon glyphicon-user"></i>
                                            <input type="text" name="email" placeholder="Usuario"/>&nbsp
                                            <i style="color: white;" class="glyphicon glyphicon-lock"></i>
                                            <input type="password" name="password_login" placeholder="Contraseña"/>&nbsp
                                            <input style="margin-top: -3px;" type="submit" class="btn btn-sm btn-warning" value="Login">      
                                        </div>
                                    </form>
                                </div>                
                            </c:if> 
                            <c:if test="${sessionScope.user!=null}">
                                <div class="content" id="usuario">
                                    <form role="form" action="/COQUEBA/controlador/logout">                      
                                        <div class="text-right"  style="display:inline; width: auto; float:right; margin-top:-21px; margin-right: 20px;">   
                                            <p style=" color: white; margin-bottom:-1px;">${sessionScope.user}</p>
                                            <input type="submit" style="display:inline; " class="btn btn-sm btn-danger " value="Logout">
                                        </div>

                                    </form>
                                </div>
                            </c:if>



                        </nav>   
                        <!-- /. NAV TOP  -->
                        <nav class="navbar-default navbar-side" role="navigation">
                            <div class="sidebar-collapse">
                                <ul class="nav text-center" id="main-menu">
                                    <li class="text-center">
                                        <c:if test="${sessionScope.user==null}">    
                                        <img src="/COQUEBA/assets/img/find_user.png" class="user-image img-responsive"/>
                                        </c:if>
                                        <c:if test="${sessionScope.user!=null}">
                                            <img class="img-circle" style="width:100px;height:100px; margin-top: 20px; margin-bottom: 20px;" src="/COQUEBA/assets/img_users/${sessionScope.user}.jpg" alt="" />
                                        </c:if>
                                    </li>

                                    <li>
                                        <a   href="/COQUEBA/controlador/home" ><span style="vertical-align: middle;" class="fa-3x glyphicon glyphicon-home" aria-hidden="true"></span>  Home</a>
                                    </li> 
                                    <li>
                                        <a  href="/COQUEBA/controlador/articulos" ><span style="vertical-align: middle;" class="fa-3x glyphicon glyphicon-th-large" aria-hidden="true"></span>  Ver Artículos</a>
                                    </li>

                                    <c:choose>	
                                        <c:when test="${sessionScope.user==null}">
                                            <li  >
                                                <a style="background:#d9534f;" href="/COQUEBA/controlador/alta" ><span style="vertical-align: middle;" class="fa-3x glyphicon glyphicon-pencil" aria-hidden="true"></span>  Registrarse</a>
                                            </li> 
                                        </c:when>
                                        <c:otherwise>
                                            <li>
                                                <a  href="/COQUEBA/controlador/publicar" ><span style="vertical-align: middle;" class="fa-3x glyphicon glyphicon-plus" aria-hidden="true"></span>  Publicar Artículo</a>
                                            </li>
                                            <li  >
                                                <a  href="/COQUEBA/controlador/interes" ><span style="vertical-align: middle;" class="fa-3x glyphicon glyphicon-heart" aria-hidden="true"></span>  Mis Articulos de Interés</a>
                                            </li>
                                        </c:otherwise>                                
                                    </c:choose>	
                                </ul>

                            </div>


                        </nav>

                        <!-- /. NAV SIDE  -->
                        <div id="page-wrapper" >
                            <div id="page-inner">
                                <div class="row">
                                    <div class="col-md-12">
                                        <h2 style="font-family: 'Chewy', cursive;">Registrarse</h2>   

                                        <c:if test="${applicationScope.wrong_user!=null}">
                                            <div class="alert alert-danger" id="articulo_publicado" role="alert">¡Vaya, parece que no existe esa combinación de usuario y contraseña!</div>
                                        </c:if>
                                    </div>
                                </div>
                                <!-- /. ROW  -->
                                <hr />

                                <!-- SECTION PRINCIPAL -->

                                <section  style="margin-bottom: 100px; margin-top: 1%;">     

                                    <form id="f"  onsubmit="return validar();" enctype="multipart/form-data" method="POST" action="/COQUEBA/controlador/guardar" style="margin-left: 5%;">
                                        <section class="container-fluid">                  
                                            <fieldset class="col-sm-6">

                                                <section id="validar_email">
                                                    <span  style="color: red;" id="spanCorreo"></span>
                                                    <div class="form-group input-group" id="div_form_email">                   
                                                        <span class="input-group-addon">@</span>
                                                        <input type="email" class="form-control" id="email" onchange="validarEmail_AJAX()" placeholder="E-mail" name="correo"></div></section><span  style="color: red;" id="spanClave"></span>


                                                <div class="form-group input-group" id="div_form_clave">                   
                                                    <span class="glyphicon glyphicon-lock input-group-addon"></span>
                                                    <input style="margin-top: 2px;" type="password" class="form-control" placeholder="Clave" name="password1"></div>

                                                <div class="form-group input-group">                   
                                                    <span class="glyphicon glyphicon-lock input-group-addon"></span>
                                                    <input style="margin-top: 2px;" type="password" class="form-control" placeholder="Repetir Clave" name="password2"></div><span style="color: red;" id="spanName"></span>

                                                <div class="form-group input-group" id="div_form_nombre">                   
                                                    <span class="glyphicon glyphicon-user input-group-addon"></span>
                                                    <input style="margin-top: 2px;" type="text" class="form-control" placeholder="Nombre" name="name"></div>

                                                <div class="form-group input-group">                   
                                                    <span class="glyphicon glyphicon-map-marker input-group-addon"></span>
                                                    <input style="margin-top: 2px;" type="text" class="form-control" placeholder="Dirección" name="direccion"></div>

                                                <div class="form-group input-group">                   
                                                    <span class="glyphicon glyphicon-envelope input-group-addon"></span>
                                                    <input  style="margin-top: 2px;" class="form-control" placeholder="CP" id="cp" type="text" pattern="[0-9]{5}" title="Formato incorrecto" name="cp"></div>

                                                <div class="form-group input-group">                   
                                                    <span class="glyphicon glyphicon-phone input-group-addon"></span>
                                                    <input style="margin-top: 2px;" type="text" class="form-control" id="telefono" placeholder="Teléfono" pattern="[0-9]{9}" title="Formato incorrecto" name="telefono"></div>

                                                <div class="form-group input-group">                   
                                                    <span class="glyphicon glyphicon-globe input-group-addon"></span>
                                                    <input style="margin-top: 2px;" type="url" class="form-control" placeholder="Facebook" name="fb"></div><br>
                                                    <div class="form-group" id="div_user_foto">
                                                        <label>Selecciona tu imagen de perfil</label>
                                                        
                                                        <input name="file2" type="file" id="adjuntar_foto_user" accept="image/png,image/jpg,image/jpeg">
                                                    </div>                
                                                    <br><br>                                                         
                                                            </fieldset>

                                                            
                                                            </section>
                                                            <input type="submit" class="btn btn-danger btn-lg" style="margin-left: 40%" value="Confirmar">                     
                                                                </form>



                                                                </section>



                                                                </div>


                                                                </div>
                                                                <!-- /. PAGE INNER  -->
                                                                </div>
                                                                <!-- /. PAGE WRAPPER  -->


                                                                <!-- /. WRAPPER  -->


                                                                <!-- SCRIPTS -AT THE BOTOM TO REDUCE THE LOAD TIME-->
                                                                <!-- JQUERY SCRIPTS -->
                                                                <script src="/COQUEBA/assets/js/jquery-1.10.2.js"></script>
                                                                <!-- BOOTSTRAP SCRIPTS -->
                                                                <script src="/COQUEBA/assets/js/bootstrap.min.js"></script>
                                                                <!-- METISMENU SCRIPTS -->
                                                                <script src="/COQUEBA/assets/js/jquery.metisMenu.js"></script>
                                                                <!-- CUSTOM SCRIPTS -->
                                                                <script src="/COQUEBA/assets/js/custom.js"></script>
                                                                <script src="/COQUEBA/assets/js/ajax.js"></script>

                                                                </body>
                                                                </html>

