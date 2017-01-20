

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
   <link href="https://fonts.googleapis.com/css?family=Chewy" rel="stylesheet">
   <link href="https://fonts.googleapis.com/css?family=Vampiro+One" rel="stylesheet"> 
       
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
                <a class="navbar-brand" style="padding-top: -10px;font-family: 'Vampiro One', cursive; font-size: 3em; color: white;" href="Home.html" >TR</a> 
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
                        <a  href="/COQUEBA/controlador/articulos" ><span  style="vertical-align: middle;" class="fa-3x glyphicon glyphicon-th-large" aria-hidden="true"></span>  Ver Artículos</a>
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
                        <a style="background:#d9534f;" href="/COQUEBA/controlador/interes" ><span  style="vertical-align: middle;"class="fa-3x glyphicon glyphicon-heart" aria-hidden="true"></span>  Mis Articulos de Interés</a>
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
                     <h2 style="font-family: 'Chewy', cursive;">Articulos de interes </h2>  
                     <c:if test="${sessionScope.borra_favorito!=null}">
                         <div class="alert alert-success" id="mensaje_fov" role="alert">¡Articulo eliminado con exito!</div>
                     </c:if>
                    </div>
                </div>
                 <!-- /. ROW  -->
                 <hr />
                
                 <!-- SECTION PRINCIPAL -->
                 
                 <section id="recommended-item-carousel" class="carousel slide" data-ride="carousel" id="articulos"> <!--ARTICULOS-->

                    <c:choose>
                        <c:when test="${!empty sessionScope.articulos_favoritos}">
                           <c:forEach var="art" items="${sessionScope.articulos_favoritos}">
                                    <div class="col-sm-4">
                                        <div class="product-image-wrapper">
                                            <div class="productinfo text-center">
                                                <img style="width:420px;height:320px;" src="/COQUEBA/assets/img_articulos/${art.nombre}${art.año}${art.cp}.jpg" alt="" />
                                                <h3 style="font-size: 3em; font: yellow;">${art.precio}€</h3>
                                                <h2>${art.nombre}</h2>
                                                
                                                <form class="container-fluid row" style="margin-bottom: 3%;">
                                                    <p class="col-md-1" name="p_${art.id}" style="color: white; display:none;">${art.id}</p>
                                                    <div class="col-md-4"></div>                  
                                                     <a  href="/COQUEBA/controlador/borrarFavorito?id=${art.id}"><span class='glyphicon glyphicon-remove-circle btn btn-danger col-md-2' style='font-size: 2em; margin: 1%;'></span></a>
                                                     <a  href="/COQUEBA/controlador/detalles?id=${art.id}"><span class='glyphicon glyphicon-info-sign btn btn-warning col-md-2' style='font-size: 2em; margin: 1%;'></span></a>                                                
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>                    
                        </c:when>
                        <c:otherwise>
                              <p>No tienes articulos marcados como favoritos </p>  
                        </c:otherwise>
                    </c:choose>
                  
                       
              </section>
          </section><!--/recommended_items-->
                
          


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
    
   
</body>
</html>
