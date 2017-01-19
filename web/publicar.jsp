<%-- 
    Document   : alta
    Created on : 15-ene-2017, 20:19:11

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
                <a class="navbar-brand" style="padding-top: -10px;font-family: 'Vampiro One', cursive; font-size: 3em; color: #white;" href="Home.html">TR</a> 
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
                        <a href="../src/java/edu/com/tradder/Controlador.java"></a>
                    </li> 
                        </c:when>
                        <c:otherwise>
                    <li>
                        <a  style="background:#d9534f;" href="/COQUEBA/controlador/publicar" ><span style="vertical-align: middle;" class="fa-3x glyphicon glyphicon-plus" aria-hidden="true"></span>  Publicar Artículo</a>
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
                     <h2>Publicar Nuevo Artículo</h2>   
                       
                    </div>
                </div>
                 <!-- /. ROW  -->
                 <hr />
                
                  <!-- SECTION PRINCIPAL -->
                 
                 
                 <section  style="margin-bottom: 100px; margin-top: 1%;">     
                   
                     <form id="f"  onsubmit="" enctype="multipart/form-data" method="POST" action="/COQUEBA/controlador/validar_articulo" style="margin-left: 5%;">
                     <section class="container-fluid">                  
                       <fieldset class="col-sm-6">

                              <div class="form-group input-group" id="div_form_nombre">                   
                              <span class="glyphicon glyphicon-pencil input-group-addon"></span>
                              <input style="margin-top: 2px;" type="text" class="form-control" placeholder="Nombre" name="name"></div>

                              <div class="form-group input-group">                   
                              <span class="glyphicon glyphicon-map-marker input-group-addon"></span>
                              <input  style="margin-top: 2px;" class="form-control" placeholder="CP" id="cp" type="text" pattern="[0-9]{5}" title="Formato incorrecto" name="cp"></div>

                              <div class="form-group input-group">                   
                              <span class="glyphicon glyphicon-euro input-group-addon"></span>
                              <input style="margin-top: 2px;" type="text" class="form-control" id="precio" placeholder="Precio" pattern="[0-9]" title="Formato incorrecto" name="precio"></div>

                              <div class="form-group input-group">                   
                              <span class="glyphicon glyphicon-calendar input-group-addon"></span>
                              <input style="margin-top: 2px;" type="text" pattern="[0-9]{4}" class="form-control" placeholder="Año de compra" name="ano"></div><br>
                              
                              <div class="form-group">
                                  <label>Descripción del artículo</label>
                                  <textarea placeholder="Descripción" class="form-control" rows="3" name="descripcion"></textarea>
                              </div>

                              <div class="form-group">
                                            <label>Categoría</label>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="optionsRadios" id="CPU" value="CPU" checked />CPU
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="optionsRadios" id="GPU" value="GPU"/>GPU
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="optionsRadios" id="procesadores" value="Procesadores"/>Procesadores
                                                </label>
                                            </div>
                              </div>

                              <div class="form-group">
                                            <label>Estado del artículo</label>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="optionsRadios2" id="Nuevo" value="Nuevo" checked />Nuevo
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="optionsRadios2" id="Seminuevo" value="Seminuevo"/>Seminuevo
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="optionsRadios2" id="Deteriorado" value="Deteriorado"/>Deteriorado
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="optionsRadios2" id="Antiguo" value="Antiguo"/>Antiguo
                                                </label>
                                            </div>
                              </div>

                              <div class="form-group">
                                <label>Imagen del artículo</label>
                                
                                <input name="file1" type="file" id="adjuntar" size="12">
                              </div>

                              </select><br><br>                                                         
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
   
</body>
</html>