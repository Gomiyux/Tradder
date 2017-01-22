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
                                <a class="navbar-brand"   style="padding-top: -10px;font-family: 'Vampiro One', cursive; font-size: 3em; color: #white;"href="Home.html" >TR</a> 
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
                                        <img src="/COQUEBA/assets/img/find_user.png" class="user-image img-responsive"/>
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
                                                <a  href="/COQUEBA/controlador/alta" ><span style="vertical-align: middle;" class="fa-3x glyphicon glyphicon-pencil" aria-hidden="true"></span>  Registrarse</a>
                                            </li> 
                                        </c:when>
                                        <c:otherwise>
                                            <li>
                                                <a  href="/COQUEBA/controlador/publicar" ><span style="vertical-align: middle;" class="fa-3x glyphicon glyphicon-plus" aria-hidden="true"></span>  Publicar Artículo</a>
                                            </li>
                                            <li  >
                                                <a href="/COQUEBA/controlador/interes" ><span style="vertical-align: middle;" class="fa-3x glyphicon glyphicon-heart" aria-hidden="true"></span>  Mis Articulos de Interés</a>
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
                                        <h2 style="font-family: 'Chewy', cursive;">Detalles</h2> 
                                        <c:if test="${applicationScope.wrong_user!=null}">
                                            <div class="alert alert-danger" id="articulo_publicado" role="alert">¡Vaya, parece que no existe esa combinación de usuario y contraseña!</div>
                                        </c:if>
                                        <div style="display:none" class="alert alert-success" id="comentario_publicado" role="alert">¡Comentario guardado satisfactoriamente!</div>    
                                    </div>
                                </div>
                                <!-- /. ROW  -->
                                <hr />

                                <!-- SECTION PRINCIPAL -->


                                <section class="row"> <!-- SECCION DE DETALLES DEL ARTICULO -->
                                    <div class="col-md-1" ></div>
                                    <div style="margin-top: 4%" class="col-md-3">
                                        <div class="product-image-wrapper">
                                            <div class="productinfo text-center">
                                                <img style="width:420px;height:320px;" src="/COQUEBA/assets/img_articulos/${requestScope.articuloDetalle.nombre}${requestScope.articuloDetalle.año}${requestScope.articuloDetalle.cp}.jpg" alt="" />                                         
                                            </div>
                                        </div>
                                    </div>
                                    <div style="margin-top: 4%; margin-left: 1%;" class="col-md-7">
                                        <div class="panel panel-danger">
                                            <!-- Default panel contents -->
                                            <div style="background-color: #C90000; font-size: 2.5em; color:black; font-family: 'Chewy', cursive;" class="panel-heading">${requestScope.articuloDetalle.nombre}</div>
                                            <div class="panel-body">

                                                <strong>Descripcion:</strong> ${requestScope.articuloDetalle.descripcion}
                                            </div>

                                            <!-- Lista de detalles -->
                                            <ul class="list-group">
                                                <li class="list-group-item">
                                                    <strong>Precio: </strong>${requestScope.articuloDetalle.precio}€   
                                                </li>
                                                <li class="list-group-item">
                                                    <strong>Categoria: </strong>${requestScope.articuloDetalle.categoria}
                                                </li>
                                                <li class="list-group-item">
                                                    <strong>Estado: </strong>${requestScope.articuloDetalle.estado}
                                                </li>
                                                <li class="list-group-item">
                                                    <strong>Año: </strong>${requestScope.articuloDetalle.año}
                                                </li>
                                                <li class="list-group-item">
                                                    <strong>Codigo Postal: </strong>${requestScope.articuloDetalle.cp}
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-md-1"></div>
                                </section>                

                                <c:choose>	
                                    <c:when test="${sessionScope.user==null}">
                                        <section style="margin-top: 20px;" class="row">
                                            <div class="col-md-1"></div>
                                            <div class="alert alert-warning col-md-10 text-center" role="alert">
                                                Debes iniciar sesión para poder comentar ¿No tienes una cuenta?  <a href="/COQUEBA/controlador/alta" class="alert-link">REGISTRATE</a> es gratis.
                                            </div>
                                            <div class="col-md-1"></div>
                                        </section>

                                    </c:when>
                                    <c:otherwise>
                                        <section style="margin-top: 20px;" class="row">
                                            <div class="col-md-1"></div>
                                            <div class="well well-lg col-md-10">
                                                <strong>Publicar un comentario:</strong>
                                                <form id="formulario_comentario">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <br> 
                                                                <div class="form-group">                                                                                
                                                                    <textarea style="width:100%;" class="form-control" rows="6" id="comment"></textarea>
                                                                </div>

                                                        </div>

                                                        <div class="col-md-6">
                                                            <strong>Selecciona la privacidad de tu comentario:</strong>
                                                            <hr>
                                                                <div class="radio">
                                                                    <label><input type="radio" value="Publico" id="radiopublico" name="comentarioradio" checked>Publico <i>(Todo el mundo verá este comentario)</i></label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label><input type="radio" value="Vendedor" id="radiovendedor" name="comentarioradio">Vendedor <i>(Solo tu y el vendedor vereis el comentario)</i></label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label><input type="radio" value="Personal" id="radiopersonal" name="comentarioradio">Personal <i>(Nadie excepto tu verá este comentario)</i></label>
                                                                </div>
                                                                <hr>

                                                                    </div>
                                                                    </div>
                                                                    <div class="row text-center">
                                                                        <button type="button" onclick="enviar_comentario(${requestScope.articuloDetalle.id})" class="btn btn-warning btn-md">Enviar Comentario</button>
                                                                    </div>
                                                                    </form>
                                                                    </div>
                                                                    <div class="col-md-1"></div>
                                                                    </section>
                                                                </c:otherwise>                                
                                                            </c:choose>	   


                                                            <section class="row" style="margin-top: 30px;"> <!-- SECCION DE COMENTARIOS DEL ARTICULO -->
                                                                <div class="col-md-1" style="display:inline;"></div>
                                                                <div class="panel panel-danger col-md-10" style="padding-bottom: 40px;">
                                                                    <div class="panel-heading text-center" style="background-color: #C90000; color :white;"><span style="background-color: white; color: black" id="numero_comentarios" class="badge"> ${sessionScope.num_comentarios}</span> COMENTARIOS</div>  
                                                                    <hr>
                                                                        <div id="comment_wrapper">
                                                                            <c:if test="${sessionScope.comentarios!=null}">
                                                                                <c:forEach var="comentario" items="${sessionScope.comentarios}">
                                                                                    <div class="row">
                                                                                        <div class="col-md-1"></div>
                                                                                        <div class="media col-md-10">
                                                                                            <div class="media-left">
                                                                                                <a href="#">
                                                                                                    <img class="media-object" src="/COQUEBA/assets/img/user.png" style="width:64px; height: 64px;" alt="">
                                                                                                </a>
                                                                                            </div>
                                                                                            <div class="media-body">

                                                                                                <h4 class="media-heading"><strong>${comentario.autor.nombre}</strong></h4>
                                                                                                <p>${comentario.texto}</p>

                                                                                                <div class="text-right">
                                                                                                    <img style="width:100px; height: 18px;" src="/COQUEBA/assets/img/five-stars.png">
                                                                                                </div>
                                                                                                <p class="text-right" style="font-size: 1em;">2017</p>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <hr>
                                                                                </c:forEach>   
                                                                                
                                                                                
                                                                            </c:if>                                                                            
                                                                        </div>
                                                                       
                                                                </div>
                                                                <div class="col-md-1"></div>

                                                            </section>    



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
