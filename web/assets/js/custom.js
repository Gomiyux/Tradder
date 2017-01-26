


/*=============================================================
    Authour URI: www.binarycart.com
    License: Commons Attribution 3.0

    http://creativecommons.org/licenses/by/3.0/

    100% To use For Personal And Commercial Use.
    IN EXCHANGE JUST GIVE US CREDITS AND TELL YOUR FRIENDS ABOUT US
   
    ========================================================  */


(function ($) {
    "use strict";
    var mainApp = {

        main_fun: function () {
            /*====================================
            METIS MENU 
            ======================================*/
            $('#main-menu').metisMenu();

            /*====================================
              LOAD APPROPRIATE MENU BAR
           ======================================*/
            $(window).bind("load resize", function () {
                if ($(this).width() < 768) {
                    $('div.sidebar-collapse').addClass('collapse')
                } else {
                    $('div.sidebar-collapse').removeClass('collapse')
                }
            });

            /*====================================
            MORRIS BAR CHART
         ======================================*/
            Morris.Bar({
                element: 'morris-bar-chart',
                data: [{
                    y: '2006',
                    a: 100,
                    b: 90
                }, {
                    y: '2007',
                    a: 75,
                    b: 65
                }, {
                    y: '2008',
                    a: 50,
                    b: 40
                }, {
                    y: '2009',
                    a: 75,
                    b: 65
                }, {
                    y: '2010',
                    a: 50,
                    b: 40
                }, {
                    y: '2011',
                    a: 75,
                    b: 65
                }, {
                    y: '2012',
                    a: 100,
                    b: 90
                }],
                xkey: 'y',
                ykeys: ['a', 'b'],
                labels: ['Series A', 'Series B'],
                hideHover: 'auto',
                resize: true
            });

            /*====================================
          MORRIS DONUT CHART
       ======================================*/
            Morris.Donut({
                element: 'morris-donut-chart',
                data: [{
                    label: "Download Sales",
                    value: 12
                }, {
                    label: "In-Store Sales",
                    value: 30
                }, {
                    label: "Mail-Order Sales",
                    value: 20
                }],
                resize: true
            });

            /*====================================
         MORRIS AREA CHART
      ======================================*/

            Morris.Area({
                element: 'morris-area-chart',
                data: [{
                    period: '2010 Q1',
                    iphone: 2666,
                    ipad: null,
                    itouch: 2647
                }, {
                    period: '2010 Q2',
                    iphone: 2778,
                    ipad: 2294,
                    itouch: 2441
                }, {
                    period: '2010 Q3',
                    iphone: 4912,
                    ipad: 1969,
                    itouch: 2501
                }, {
                    period: '2010 Q4',
                    iphone: 3767,
                    ipad: 3597,
                    itouch: 5689
                }, {
                    period: '2011 Q1',
                    iphone: 6810,
                    ipad: 1914,
                    itouch: 2293
                }, {
                    period: '2011 Q2',
                    iphone: 5670,
                    ipad: 4293,
                    itouch: 1881
                }, {
                    period: '2011 Q3',
                    iphone: 4820,
                    ipad: 3795,
                    itouch: 1588
                }, {
                    period: '2011 Q4',
                    iphone: 15073,
                    ipad: 5967,
                    itouch: 5175
                }, {
                    period: '2012 Q1',
                    iphone: 10687,
                    ipad: 4460,
                    itouch: 2028
                }, {
                    period: '2012 Q2',
                    iphone: 8432,
                    ipad: 5713,
                    itouch: 1791
                }],
                xkey: 'period',
                ykeys: ['iphone', 'ipad', 'itouch'],
                labels: ['iPhone', 'iPad', 'iPod Touch'],
                pointSize: 2,
                hideHover: 'auto',
                resize: true
            });

            /*====================================
    MORRIS LINE CHART
 ======================================*/
            Morris.Line({
                element: 'morris-line-chart',
                data: [{
                    y: '2006',
                    a: 100,
                    b: 90
                }, {
                    y: '2007',
                    a: 75,
                    b: 65
                }, {
                    y: '2008',
                    a: 50,
                    b: 40
                }, {
                    y: '2009',
                    a: 75,
                    b: 65
                }, {
                    y: '2010',
                    a: 50,
                    b: 40
                }, {
                    y: '2011',
                    a: 75,
                    b: 65
                }, {
                    y: '2012',
                    a: 100,
                    b: 90
                }],
                xkey: 'y',
                ykeys: ['a', 'b'],
                labels: ['Series A', 'Series B'],
                hideHover: 'auto',
                resize: true
            });
           
     
        },

        initialization: function () {
            mainApp.main_fun();

        }

    }
    // Initializing ///

    $(document).ready(function () {
        mainApp.main_fun();
    });

}(jQuery));


/*====================================
    FORMULARIO
 ======================================*/



function validar(){

    var spanName= document.getElementById("spanName");
    spanName.innerHTML="";
    var spanClave= document.getElementById("spanClave");
    spanClave.innerHTML="";
    var div_clave= document.getElementById("div_form_clave");
    div_clave.classList.remove("has-error");
    var div_nombre= document.getElementById("div_form_nombre");
    div_nombre.classList.remove("has-error");
    var div_captcha= document.getElementById("div_form_captcha");
    div_captcha.classList.remove("has-error");
    var ok=true;    
    
    

    var f = document.getElementById("f");

    if (f.name.value=="") {
        ok=false;
        spanName.innerHTML="*Nombre Requerido";
        div_nombre.classList.add("has-error");
    };
    
    if (f.password1.value!==f.password2.value){
            ok=false;
            spanClave.innerHTML="*Las claves no coincide";
            div_clave.classList.add("has-error");      
        };
        
    if (f.password1.value=="") {
        ok=false;
        spanClave.innerHTML="*Clave Requerida";
        div_clave.classList.add("has-error");
    };

    if(f.jcaptcha.value!=="captcha"){ //Captcha sin funcionalidad
        ok=false;
        div_captcha.classList.add("has-error");
    };
    
    if(div_form_email.classList.contains("has-error")==true){
        ok=false;     
    }
    
    return ok;
}


function validarPublicacion(){
    var spanName= document.getElementById("spanNameART");
    spanName.innerHTML="";
    var spanPrecio= document.getElementById("spanPrecioART");
    spanPrecio.innerHTML="";
    var spanCp= document.getElementById("spanCpART");
    spanCp.innerHTML="";
    var spanFoto= document.getElementById("spanImagenART");
    spanFoto.innerHTML="";
    
    var div_cp= document.getElementById("div_art_cp");
    div_cp.classList.remove("has-error");
    var div_nombre= document.getElementById("div_art_nombre");
    div_nombre.classList.remove("has-error");
    var div_precio= document.getElementById("div_art_precio");
    div_precio.classList.remove("has-error");
    var div_foto= document.getElementById("div_art_foto");
    var ok2=true;
    var f2 = document.getElementById("f2");
    
    if(f2.file1.value!=""){
        var file= f2.file1.value.toString();    
        var extension = (file.substring(file.lastIndexOf("."))).toLowerCase();
        var sizeArch = f2.file1.files[0].size;
    }
   

    if (f2.precio.value=="") {
        ok2=false;
        spanPrecio.innerHTML="*Precio Requerido";
        div_precio.classList.add("has-error");
    };
    
    if (f2.cp.value=="") {
        ok2=false;
        spanCp.innerHTML="*CP Requerido";
        div_cp.classList.add("has-error");
    };
    
    if (f2.name.value=="") {
        ok2=false;
        spanName.innerHTML="*Nombre Requerido";
        div_nombre.classList.add("has-error");
    };
    
    if (f2.file1.value=="") {
        ok2=false;
        spanFoto.innerHTML="*Imagen Requerida";
    }
    
    else{   
        /*
        if (extension!="jpg" && extension!="jpeg" && extension!="png") {
            ok2=false;
            spanFoto.innerHTML="*Formato no compatible (Debe ser .jpg, .jpg o .png)";
        };
            */
        if (sizeArch > 5242880) {
            ok2=false;
            spanFoto.innerHTML="*La imagen no puede superar los 5Mb";
        };  
    }
    
    
    return ok2;
}

function rangomaxmin(){
    //console.log(document.getElementById("rango").value);   
    var rango= document.getElementById("rango").value;
    var rangos= rango.split(",");
    document.getElementById("min").innerHTML=( rangos[0]+"€");
    document.getElementById("max").innerHTML=(rangos[1]+ "€");
}


