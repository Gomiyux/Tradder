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

    var categoria1 = document.getElementByName("categoria_radio");
    var categoria2 = document.getElementByName("categoria_radio2");
    var categoria3 = document.getElementByName("categoria_radio3");
    
    var cp = document.getElementByName("cp");
    
    var rango= document.getElementById("rango").value;
    var rangos= rango.split(",");
    
    
    var datos = "cp=" + encodeURIComponent(cp.value) +
            "&pmenor=" + encodeURIComponent(rangos[0].value)+
            "&pmayor=" + encodeURIComponent(rangos[1].value)+
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
        }
    }

}