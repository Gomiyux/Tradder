<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <c:forEach var="art2" items="${sessionScope.articulos2}">

                                    <div class="col-sm-4">
                                        
                                        <div class="product-image-wrapper">
                                            <div class="productinfo text-center">
                                                <img style="width:420px;height:320px;" src="/COQUEBA/assets/img_articulos/${art2.nombre}${art2.año}${art2.cp}.jpg" alt="" />
                                                <h3 style="font-size: 3em; font: yellow;">${art2.precio}€</h3>
                                                <h2 style="font-family: 'Chewy', cursive;">${art2.nombre}</h2>
                                                
                                                <form class="container-fluid row" style="margin-bottom: 3%;">
                                                    <p class="col-md-1" name="p_${art.id}" style="color: white; display:none;">${art2.id}</p>
                                                    <div class="col-md-4"></div> 
                                                    <c:if test="${sessionScope.user==null}">
                                                        <a id="registrate"  title="Registrate para añadir favoritos" ><span class='glyphicon glyphicon-heart btn btn-default col-md-2' style='font-size: 2em; margin: 1%;'></span></a>
                                                    </c:if>
                                                    <c:if test="${sessionScope.user!=null}">
                                                        <a  href="/COQUEBA/controlador/addFavoritos?id=${art2.id}"><span class='glyphicon glyphicon-heart btn btn-danger col-md-2' style='font-size: 2em; margin: 1%;'></span></a>
                                                    </c:if>                                                    
                                                     <a  href="/COQUEBA/controlador/detalles?id=${art2.id}"><span class='glyphicon glyphicon-info-sign btn btn-warning col-md-2' style='font-size: 2em; margin: 1%;'></span></a>                                                
                                                </form>
                                            </div>
                                        </div>
                                    </div>
</c:forEach>                         
                        