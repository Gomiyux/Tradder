/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var xhr;


function init_ajax(){
    if (window.XMLHttpRequest) {
        xhr = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        xhr = new ActiveXObject("Microsoft.XMLHTTP");
    }   
    
}

function filtrar() {

    init_ajax();
    var url = "filtro";
    xhr.open("POST", url, true);
    xhr.onreadystatechange = fin_filtro;
    
    var categoria1 = "off";
    var categoria2 = "off";
    var categoria3 = "off";
    
    if(document.getElementById("categoria_radio").checked) categoria1 = "on";
    if(document.getElementById("categoria_radio2").checked) categoria2 = "on";
    if(document.getElementById("categoria_radio3").checked) categoria3 = "on";

    
    
    var cp = document.getElementById("cp").value;
    
    var rango= document.getElementById("rango").value;
    var rangos= rango.split(",");
    
    
    var datos = "cp=" + encodeURIComponent(cp) +
            "&pmenor=" + encodeURIComponent(rangos[0])+
            "&pmayor=" + encodeURIComponent(rangos[1])+
            "&categoria1=" + encodeURIComponent(categoria1) +
            "&categoria2=" + encodeURIComponent(categoria2) +
            "&categoria3=" + encodeURIComponent(categoria3) ;
            
    
    
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send(datos);

}

function fin_filtro() {
    if (xhr.readyState === 4) {
        if (xhr.status === 200) {
            //document.getElementById("msg").innerHTML = xhr.responseText;
            
            var articu =document.getElementById("recommended-item-carousel2");
            articu.innerHTML = xhr.responseText;
           
            
             //("#recommended-item-carousel3").load(location.href+" #recommended-item-carousel3>*","");
            //$('#recommended-item-carousel3').load(location.href +  ' #recommended-item-carousel3');
        }
    }

}

function enviar_comentario(id_articulo){
    
    init_ajax();
    var url = "guardar_comentario";
    xhr.open("POST", url, true);
    xhr.onreadystatechange = fin_comentario;
        
    var privacidad;    
    
    if(document.getElementById("radiopublico").checked) privacidad = document.getElementById("radiopublico").value;
    if(document.getElementById("radiovendedor").checked) privacidad = document.getElementById("radiovendedor").value;
    if(document.getElementById("radiopersonal").checked) privacidad = document.getElementById("radiopersonal").value;
    
    
    
    var texto = document.getElementById("comment").value;
    
    var datos = "privacidad=" + encodeURIComponent(privacidad) +
            "&texto=" + encodeURIComponent(texto) +
             "&id_articulo=" + encodeURIComponent(id_articulo);
            
    
    
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send(datos);
    
}

function fin_comentario(){
    
    if (xhr.readyState === 4) {
        if (xhr.status === 200) {
            
            
            var articu =document.getElementById("comment_wrapper");
            articu.innerHTML = xhr.responseText;
            document.getElementById("comentario_publicado").style.display="block";
            var num= parseInt($('#numero_comentarios').text());
            var num= num+1;
            document.getElementById("numero_comentarios").textContent=num;
            
           
            
            
        }
    }   
}

function validarEmail_AJAX(){
    init_ajax();
    var url = "validarEmail";
    xhr.open("POST", url, true);
    xhr.onreadystatechange = fin_validarEmail;
    
    var emailAUX=document.getElementById("email").value;
    
    var datos = "emailValidar=" + encodeURIComponent(emailAUX);

    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send(datos);
}

function fin_validarEmail() {
    if (xhr.readyState === 4) {
        if (xhr.status === 200) {        
            var vali =document.getElementById("validar_email");
            console.log(xhr.responseText[7]);
            if(xhr.responseText[7]=="M"){
               vali.innerHTML = xhr.responseText;     
            }
            else{
               var div_email=document.getElementById("div_form_email");
               div_email.classList.remove("has-error");
               document.getElementById("spanCorreo").textContent="";
            }        
        }
    }

}