<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:if test="${sessionScope.malEmail==0}"><!--M-->
    <span  style="color: red;" id="spanCorreo">*Correo ya existente</span>
    <div class="form-group input-group has-error" id="div_form_email">                   
        <span class="input-group-addon">@</span>
        <input type="email" class="form-control" id="email" onchange="validarEmail_AJAX()" placeholder="E-mail" name="correo"></div> 
    </c:if>
    <c:if test="${sessionScope.malEmail==1}"><!--B-->
    <div class="form-group input-group">                   
        <span class="input-group-addon">@</span>
        <input type="email" class="form-control" id="email" onchange="validarEmail_AJAX()" placeholder="E-mail" name="correo"></div>
    </c:if>
