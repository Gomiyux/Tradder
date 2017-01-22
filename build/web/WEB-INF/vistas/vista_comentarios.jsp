<%-- 
    Document   : vista_comentarios
    Created on : 20-ene-2017, 17:31:29
    Author     : carlo
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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