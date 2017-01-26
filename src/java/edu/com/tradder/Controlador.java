/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.com.tradder;

import com.sun.mail.smtp.SMTPTransport;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.UnsupportedEncodingException;
import java.security.Security;
import java.util.Date;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author SebaL
 */

@MultipartConfig
@WebServlet(name = "Controlador", urlPatterns = {"/controlador/*"})
public class Controlador extends HttpServlet {
    @PersistenceContext(unitName = "tradderPU")
    private EntityManager em;
    @Resource
    private javax.transaction.UserTransaction utx;
    
    private int i=0;

    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion;
        accion = request.getPathInfo();
        String vista;
        HttpSession session = request.getSession();
        
        session.removeAttribute("marca_favorito");
        session.removeAttribute("comentarios");
        session.removeAttribute("borra_favorito");
        session.removeAttribute("sube_articulo");
        session.removeAttribute("nuevouser");
        session.removeAttribute("wrong_user");
        ServletContext context = request.getSession().getServletContext();
        
        if(i!=0){
            context.removeAttribute("wrong_user"); 
            context.removeAttribute("nuevouser");
            i=0;
        }
        
        
        switch (accion) {
            case "/home":
                // Página Principal
                TypedQuery<Articulos> query2 = em.createNamedQuery("Articulos.findAll", Articulos.class);
                List<Articulos> result2 = query2.getResultList();
                List<Articulos> aux1 = new ArrayList<Articulos>();
                List<Articulos> aux2 = new ArrayList<Articulos>();
                int restantes=result2.size();
                int z=0;
                
                while(restantes!=0 && z!=3){
                    aux1.add(result2.get(restantes-1));
                    restantes--;
                    z++;
                }
                
                while(restantes!=0 && z!=6){
                    aux2.add(result2.get(restantes-1));
                    restantes--;
                    z++;
                }
                
                request.setAttribute("Ultimos_articulos1", aux1);
                request.setAttribute("Ultimos_articulos2", aux2);
                i++;
                vista = "/index.jsp";
                break;
            case "/login":
                // Mostrar el formulario de login
                vista = "/login.jsp";
                break;
            case "/validar":
                // Validar el usuario
                try {
                    String user = request.getParameter("email");
                    String pass = request.getParameter("password_login");
                    MessageDigest md = MessageDigest.getInstance("SHA-256");
                    md.update(pass.getBytes());
                    byte byteData[] = md.digest();
                    StringBuffer sb = new StringBuffer();
                    for (int i = 0; i < byteData.length; i++) {
                        sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
                    }
                    String pass_digest = sb.toString();
                    TypedQuery<Usuarios> query = em.createNamedQuery("Usuarios.findByNameAndPass", Usuarios.class);
                    query.setParameter("name", user);
                    query.setParameter("pwd", pass_digest);

                    List<Usuarios> lu;
                    lu = query.getResultList();
                    if (!lu.isEmpty()) {
                        Usuarios u = lu.get(0);
                        session.setAttribute("id", u.getId());
                        session.setAttribute("user", u.getEmail());
                        request.setAttribute("msg", "Login correcto.");
                        session.setAttribute("usuario", u);
                    } else {
                        request.setAttribute("msg", "Usuario o Password incorrecto.");
                        context = request.getSession().getServletContext();
                        context.setAttribute("wrong_user","yes");
                    }
                } catch (Exception e) {
                    System.err.println(e);
                    request.setAttribute("msg", "ERROR: imposible validar al usuario");
                }
                vista = "/controlador/home";
                break;
            case "/alta":
                // Mostrar el formulario de alta
                i++;
                vista = "/alta.jsp";
                break;
            case "/guardar":
                // Guardar datos de usuario
                // UNDO: Verificación de los datos
                try {
                    String email = request.getParameter("correo");
                    String nombre = request.getParameter("name");
                    String password= request.getParameter("password1");
                    String direccion = request.getParameter("direccion");
                    String telefono = request.getParameter("telefono");
                    String cp = request.getParameter("cp");
                    String facebook = request.getParameter("fb");                  

                    MessageDigest md = MessageDigest.getInstance("SHA-256");
                    md.update(password.getBytes());
                    byte byteData[] = md.digest();
                    StringBuffer sb = new StringBuffer();
                    for (int i = 0; i < byteData.length; i++) {
                        sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
                    }
                    String pass_digest = sb.toString();
                    
                    TypedQuery<Usuarios> query_email = em.createNamedQuery("Usuarios.findByEmail", Usuarios.class);
                    query_email.setParameter("emailUnicidad", email);
                    List<Usuarios> result_email = query_email.getResultList();
                    
                    
                    if(email != null && pass_digest != null && nombre != null && result_email.size()==0){
                        Usuarios u = new Usuarios();
                        u.setCp(cp);
                        u.setDireccion(direccion);
                        u.setFacebook(facebook);
                        u.setTelefono(telefono);
                        u.setNombre(nombre);
                        u.setEmail(email);
                        u.setPassword(pass_digest);
                        persist(u);
                        request.setAttribute("msg", "Usuario guardado");
                        context.setAttribute("nuevouser", "yes");
                        
                        final Part filePart = request.getPart("file2");
                        System.out.println(filePart.getSize());
                        System.out.println(filePart.getName());
                        if (filePart.getSize()!=0) {

                            /*
                            String nombre = filePart.getName();
                            Long tamano = filePart.getSize();
                            String file = filePart.getSubmittedFileName();
                            */
                            
                            String relativePathFolder = "../../web/assets/img_users";
                            String absolutePathFolder = getServletContext().getRealPath(relativePathFolder);                           
                            
                            File f = new File(absolutePathFolder + File.separator + email+".jpg");
                            
                            OutputStream p = new FileOutputStream(f);
                            InputStream filecontent;
                            filecontent = filePart.getInputStream();
                            
                            int read = 0;
                            final byte[] bytes = new byte[1024];
                            while ((read = filecontent.read(bytes)) != -1) {
                                p.write(bytes, 0, read);
                            }

                            p.close();
                            filecontent.close();
                            
                        }
                        else{
                            
                            System.out.println("LLLLEGOOOOOOS");
                            
                            String relativePathFolder = "../../web/assets/img_users";
                            String absolutePathFolder = getServletContext().getRealPath(relativePathFolder);                           
                            
                            File f = new File(absolutePathFolder + File.separator + email+".jpg");
                            
                            OutputStream p = new FileOutputStream(f);
                            InputStream filecontent;
                            filecontent = new FileInputStream(new File(absolutePathFolder + File.separator + "user.png"));
                            
                            int read = 0;
                            final byte[] bytes = new byte[1024];
                            while ((read = filecontent.read(bytes)) != -1) {
                                p.write(bytes, 0, read);
                            }

                            p.close();
                            filecontent.close();
                            
                            /*
                            System.out.println("He entrado");
                            
                            InputStream is = null;
                            OutputStream os = null;
                            try {
                                is = new FileInputStream(new File("../../web/assets/img_users/user.png"));
                                os = new FileOutputStream(new File("../../web/assets/img_users/"+email+".png"));
                                byte[] buffer = new byte[1024];
                                int length;
                                while ((length = is.read(buffer)) > 0) {
                                    os.write(buffer, 0, length);
                                }
                            } finally {
                                is.close();
                                os.close();
                            }
                            */
                           
                        }
                        
                    }
                } catch (Exception e) {
                    request.setAttribute("msg", "ERROR: Usuario NO guardado");
                }
                vista = "/controlador/home";
                break;
                
            case "/articulos":
                
                    i++;
                     TypedQuery<Articulos> query = em.createNamedQuery("Articulos.findAll", Articulos.class);
                     List<Articulos> result = query.getResultList();
                     
                     context = request.getSession().getServletContext();
                     
                     context.setAttribute("articulos", result);
                     
                     vista= "/ver_articulos.jsp";
                     
                break;
                
            case "/addFavoritos":
                              
                String auxID = request.getParameter("id");
                Long ida = Long.parseLong(auxID);
                Articulos art= new Articulos();
                TypedQuery<Articulos> q = em.createNamedQuery("Articulos.Seleccionar", Articulos.class);
                q.setParameter("id_art", ida);    
                List<Articulos> resultAUX = q.getResultList();      
                List<Articulos> articulos_favoritos = (List<Articulos>) session.getAttribute("articulos_favoritos");
              
                 if (articulos_favoritos == null) {
                    articulos_favoritos = new ArrayList<>();
                 }
                
                art = resultAUX.get(0);  
                articulos_favoritos.add(art);
                
                session.setAttribute("articulos_favoritos", articulos_favoritos);
    
                TypedQuery<Articulos> query3 = em.createNamedQuery("Articulos.findAll", Articulos.class);
                List<Articulos> result3 = query3.getResultList();
                session.setAttribute("marca_favorito", "yes");
                request.setAttribute("articulos", result3);
                
                vista="/ver_articulos.jsp";
                break;
                
            case "/borrarFavorito":
                String auxID2 = request.getParameter("id");
                Long id_borrar= Long.parseLong(auxID2);
                List<Articulos> lista_aux = (List<Articulos>) session.getAttribute("articulos_favoritos");
                int b=0;
                session.setAttribute("borra_favorito", "yes");
                Boolean encontrado=false;               
                while(b<lista_aux.size() && !encontrado){
                    if(Objects.equals(lista_aux.get(b).getId(), id_borrar)){
                        lista_aux.remove(b);
                        encontrado=true;
                    }
                    else b++;
                }
                
                session.setAttribute("articulos_favoritos", lista_aux);
                
                vista= "/interes.jsp";
                break;
                
            case "/interes":
                     vista= "/interes.jsp";
                break;   
                
            case "/logout":
                
                //
                session.removeAttribute("id");
                session.removeAttribute("user");
                session.removeAttribute("usuario");
                session.removeAttribute("comentarios");
                request.setAttribute("msg", "Usuario desconectado");
                vista = "/controlador/home";
                break;
                
            case "/publicar":
                
                vista="/publicar.jsp";
                break;
            case "/validar_articulo":
                
                               
                Articulos a;
                
                String cp = request.getParameter("cp");
                String year = request.getParameter("ano");
                String name = request.getParameter("name");
                String pvp = request.getParameter("precio");
                String categoria = request.getParameter("optionsRadios");
                String estado = request.getParameter("optionsRadios2");
                String descripcion = request.getParameter("descripcion");
                 
                if (cp != null && name != null && pvp != null) {
                    try {
                        a = new Articulos();
                        a.setAño(year);
                        a.setCp(cp);
                        a.setCategoria(categoria);
                        a.setEstado(estado);
                        a.setDescripcion(descripcion);
                        a.setNombre(name);
                        a.setPrecio(pvp);
                        a.setPropietario((Usuarios) request.getSession().getAttribute("usuario"));
                        //.setPropietario((Usuarios) session.getAttribute("id"));
                        persist(a);
                        
                        final Part filePart = request.getPart("file1");
                        if (filePart != null) {

                            /*
                            String nombre = filePart.getName();
                            Long tamano = filePart.getSize();
                            String file = filePart.getSubmittedFileName();
                            */
                            
                            String relativePathFolder = "../../web/assets/img_articulos";
                            String absolutePathFolder = getServletContext().getRealPath(relativePathFolder);                           
                            
                            File f = new File(absolutePathFolder + File.separator + name+year+cp+".jpg");
                            
                            OutputStream p = new FileOutputStream(f);
                            InputStream filecontent;
                            filecontent = filePart.getInputStream();
                            
                            int read = 0;
                            final byte[] bytes = new byte[1024];
                            while ((read = filecontent.read(bytes)) != -1) {
                                p.write(bytes, 0, read);
                            }

                            p.close();
                            filecontent.close();
                            
                        }

                    } catch (Exception ex) {
                        System.out.println(ex);
                        System.out.println("Error: Imposible persistir  articulo: " + name);
                        String msg = "<p class='error'>Error: Artículo " + name + " no creado</p>";
                    }
                } else {
                    System.out.println("Error: datos incorrectos");                   
                }

                session.setAttribute("sube_articulo", "yes");
                    
                vista = "/publicar.jsp";
                break; 
                
            case "/detalles" :
                
                
                
                String aux4 = request.getParameter("id");
                Long idDet = Long.parseLong(aux4);
                Articulos artDet= new Articulos();
                TypedQuery<Articulos> qDet = em.createNamedQuery("Articulos.Seleccionar", Articulos.class);
                qDet.setParameter("id_art", idDet);    
                List<Articulos> resultDet = qDet.getResultList();
                
                artDet = resultDet.get(0);
                
                
                
                if(request.getSession().getAttribute("usuario")==null){
                    
                    TypedQuery<Comentarios> comentario_auxiliar = em.createNamedQuery("Comentarios.findByIdAndPrivacy", Comentarios.class);
                    comentario_auxiliar.setParameter("id_articulo", Long.parseLong(aux4));
                    comentario_auxiliar.setParameter("privacidad", "Publico");
                    List<Comentarios> lista_comentarios= comentario_auxiliar.getResultList();
                    session.setAttribute("comentarios", lista_comentarios);
                    session.setAttribute("num_comentarios", lista_comentarios.size());
                    
                }
                
                else{
                    
                    
                    
                    TypedQuery<Comentarios> comentario_auxiliar = em.createNamedQuery("Comentarios.findByIdAndPrivacy", Comentarios.class);
                    comentario_auxiliar.setParameter("id_articulo", Long.parseLong(aux4));
                    comentario_auxiliar.setParameter("privacidad", "Publico");
                    
                    
                    
                    
                    TypedQuery<Comentarios> comentario_auxiliar2 = em.createNamedQuery("Comentarios.findByIdAndPrivacyAndAutor", Comentarios.class);
                    comentario_auxiliar2.setParameter("id_articulo", Long.parseLong(aux4));
                    comentario_auxiliar2.setParameter("privacidad", "Personal");
                    Usuarios aux_us = (Usuarios) request.getSession().getAttribute("usuario");
                    comentario_auxiliar2.setParameter("autor",  aux_us);
                    
                    TypedQuery<Comentarios> comentario_auxiliar3 = em.createNamedQuery("Comentarios.findByIdAndPrivacy", Comentarios.class);
                    comentario_auxiliar3.setParameter("id_articulo", Long.parseLong(aux4));
                    comentario_auxiliar3.setParameter("privacidad", "Vendedor");
                    
                   
                    
                    
                    List<Comentarios> lista_comentarios= comentario_auxiliar.getResultList();
                    List<Comentarios> lista_comentarios2= comentario_auxiliar2.getResultList();
                    List<Comentarios> lista_comentarios3= comentario_auxiliar3.getResultList();
                    
                   
                     System.out.println("El tamaño de la lista3 es: " + lista_comentarios3.size());
                    
                    
                    List<Comentarios> lista_comentarios_final = new ArrayList();
                    
                    lista_comentarios_final.addAll(lista_comentarios);
                    lista_comentarios_final.addAll(lista_comentarios2);
                    
                    
                   
                    
                    for (int j = 0; j < lista_comentarios3.size(); j++) {
                        
                        
                        System.out.println("Seba homo1");
                        
                        if(lista_comentarios3.get(j).getAutor().getId()==aux_us.getId() || lista_comentarios3.get(j).getArticulo().getPropietario().getId()==aux_us.getId()){
                            lista_comentarios_final.add(lista_comentarios3.get(j));
                            System.out.println("seba hhomo2");
                            
                        }
                        
                    }
                    
                    session.setAttribute("comentarios", lista_comentarios_final);
                    session.setAttribute("num_comentarios", lista_comentarios_final.size());
                    
                    
                }
                
                
                
                request.setAttribute("articuloDetalle", artDet);

                
                vista ="/detalles.jsp";
                break;
            case "/filtro":
                
                
                TypedQuery<Articulos> articulos_query = em.createNamedQuery("Articulos.findAll", Articulos.class);
                List<Articulos> lista_articulos = articulos_query.getResultList();
                List<Articulos> articulos_final= (List) new ArrayList<>();
                List<Articulos> articulos_aux= new ArrayList<>();
                
                
                String categoria1 = request.getParameter("categoria1");
                String categoria2 = request.getParameter("categoria2");
                String categoria3 = request.getParameter("categoria3");
                String cp_filtro = request.getParameter("cp");
                String a1=request.getParameter("pmenor");
                String b1=request.getParameter("pmayor");
                
                
                
                
                int pmenor = Integer.parseInt(a1.toString());
                int pmayor = Integer.parseInt(b1.toString());
                
                boolean categoria1b=false, categoria2b=false, categoria3b=false, cpb=false;
                
                
                
                
                if(categoria1.equals("on")){
                    
                   
                    
                    categoria1b=true;
                    
                        for (int i = 0; i < lista_articulos.size(); i++) {

                            if(lista_articulos.get(i).getCategoria().equals("CPU")) articulos_aux.add(lista_articulos.get(i));

                        }
                }
                
                if(categoria2.equals("on")){
                    
                        
                    
                        categoria2b=true;
                        
                        for (int i = 0; i < lista_articulos.size(); i++) {
                        
                            if(lista_articulos.get(i).getCategoria().equals("GPU")) articulos_aux.add(lista_articulos.get(i));
                        
                        }   
                 
                }
                
                if(categoria3.equals("on")){
                    
                    
                        
                        categoria3b=true;
                        
                        for (int i = 0; i < lista_articulos.size(); i++) {
                        
                            if(lista_articulos.get(i).getCategoria().equals("Otros")) articulos_aux.add(lista_articulos.get(i));
                        
                        }   
                    
                }

                
                if(!cp_filtro.equals("")){
                    
                        cpb=true;
                        
                        
                        
                        if(categoria1b || categoria2b || categoria3b) {
                            
                            
                            int size=articulos_aux.size();
                            ArrayList<Integer> borrar = new ArrayList<Integer>();
                            
                            for (int i = 0; i < size; i++) {
                        
                                
                                if(!articulos_aux.get(i).getCp().equals(cp_filtro))    borrar.add(i);
                                    
                                
                        
                            }  
                            
                            for(int i =0;i<borrar.size();i++){
                                
                                
                                    articulos_aux.remove((borrar.get(i).intValue())-i);
                                
                            }
                            
                        }
                        
                        else{
                            
                            for (int i = 0; i < lista_articulos.size(); i++) {
                        
                                if(lista_articulos.get(i).getCp().equals(cp_filtro)) articulos_aux.add(lista_articulos.get(i));
                        
                            }  
                        }

                }
                
                
                if(categoria1b || categoria2b || categoria3b || cpb) {
                            

                            for (int i = 0; i < articulos_aux.size(); i++) {
                        
                                if(Integer.parseInt(articulos_aux.get(i).getPrecio())>=pmenor && Integer.parseInt(articulos_aux.get(i).getPrecio())<=pmayor) articulos_final.add(articulos_aux.get(i));
                        
                            }  
                            
                }
                     
                else{
                    
                    for (int i = 0; i < lista_articulos.size(); i++) if(Integer.parseInt(lista_articulos.get(i).getPrecio())>=pmenor && Integer.parseInt(lista_articulos.get(i).getPrecio())<=pmayor) articulos_final.add(lista_articulos.get(i));
                    
                }

                
                session.setAttribute("articulos2", articulos_final);
                
                vista = "/WEB-INF/vistas/filtro_articulos.jsp";
                break;   
                
                
            case"/guardar_comentario":
                
                
                TypedQuery<Articulos> articulos_comentarios = em.createNamedQuery("Articulos.Seleccionar", Articulos.class);
                
                articulos_comentarios.setParameter("id_art", Long.parseLong(request.getParameter("id_articulo")));
                List<Articulos> lista_articulos_comentarios = articulos_comentarios.getResultList();
                Articulos articulo_comentario= lista_articulos_comentarios.get(0);
                
                TypedQuery<Usuarios> usuario_auxiliar = em.createNamedQuery("Usuarios.findById", Usuarios.class);
                usuario_auxiliar.setParameter("id", session.getAttribute("id"));
                List<Usuarios> usuarios_list= usuario_auxiliar.getResultList();
                Usuarios usuario_comentario = usuarios_list.get(0);
                
                String texto=request.getParameter("texto");
                String privacidad=request.getParameter("privacidad");
                
                  
               
                try{
                    
                Long aux5 = Long.parseLong(request.getParameter("id_articulo"));
                Comentarios comentario = new Comentarios();
                comentario.setArticulo(articulo_comentario);
                comentario.setAutor(usuario_comentario);
                comentario.setPrivacidad(privacidad);
                comentario.setTexto(texto);
                persist(comentario);
                    
                
                
                    TypedQuery<Comentarios> comentario_auxiliar = em.createNamedQuery("Comentarios.findByIdAndPrivacy", Comentarios.class);
                    comentario_auxiliar.setParameter("id_articulo", aux5);
                    comentario_auxiliar.setParameter("privacidad", "Publico");
                    
                    
                    
                    
                    TypedQuery<Comentarios> comentario_auxiliar2 = em.createNamedQuery("Comentarios.findByIdAndPrivacyAndAutor", Comentarios.class);
                    comentario_auxiliar2.setParameter("id_articulo", aux5);
                    comentario_auxiliar2.setParameter("privacidad", "Personal");
                    Usuarios aux_us = (Usuarios) request.getSession().getAttribute("usuario");
                    comentario_auxiliar2.setParameter("autor",  aux_us);
                    
                    TypedQuery<Comentarios> comentario_auxiliar3 = em.createNamedQuery("Comentarios.findByIdAndPrivacy", Comentarios.class);
                    comentario_auxiliar3.setParameter("id_articulo", aux5);
                    comentario_auxiliar3.setParameter("privacidad", "Vendedor");
                    
                   
                    
                    
                    List<Comentarios> lista_comentarios= comentario_auxiliar.getResultList();
                    List<Comentarios> lista_comentarios2= comentario_auxiliar2.getResultList();
                    List<Comentarios> lista_comentarios3= comentario_auxiliar3.getResultList();
                    
                   
                     System.out.println("El tamaño de la lista3 es: " + lista_comentarios3.size());
                    
                    
                    List<Comentarios> lista_comentarios_final = new ArrayList();
                    
                    lista_comentarios_final.addAll(lista_comentarios);
                    lista_comentarios_final.addAll(lista_comentarios2);
                    
                    
                   
                    
                    for (int j = 0; j < lista_comentarios3.size(); j++) {
                        
                        
                        
                        
                        if(lista_comentarios3.get(j).getAutor().getId()==aux_us.getId() || lista_comentarios3.get(j).getArticulo().getPropietario().getId()==aux_us.getId()){
                            lista_comentarios_final.add(lista_comentarios3.get(j));
                            
                            
                        }
                        
                    }
                    
                    session.setAttribute("comentarios", lista_comentarios_final);
                    session.setAttribute("num_comentarios", lista_comentarios_final.size());
                    
                
                }
                catch (Exception e) {
                    System.err.println(e);
                    request.setAttribute("msg", "ERROR: imposible validar al usuario");
                }
                
                
                
                
                
                vista="/WEB-INF/vistas/vista_comentarios.jsp";
                
            break;
            
                
            case "/nueva_pass":
                
                String mail_pwd = request.getParameter("email_enviar");
                TypedQuery<Usuarios> query5 = em.createNamedQuery("Usuarios.findByEmail", Usuarios.class);
                query5.setParameter("emailUnicidad", mail_pwd);  
                List<Usuarios> resultado_nueva_pwd= query5.getResultList();
                
                if(resultado_nueva_pwd.size()>0){
                    
                        try {
                            Usuarios user_reset = resultado_nueva_pwd.get(0);

                            Random rnd = new Random();
                            rnd.setSeed(System.currentTimeMillis());
                            String nueva_pass="";

                            for(int i=0; i<5;i++){
                                nueva_pass=nueva_pass+rnd.nextInt(9);
                            }

                            MessageDigest md = MessageDigest.getInstance("SHA-256");
                            md.update(nueva_pass.getBytes());
                            byte byteData[] = md.digest();
                            StringBuffer sb = new StringBuffer();
                            for (int i = 0; i < byteData.length; i++) {
                                sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
                            }
                            String pass_digest2 = sb.toString();

                            user_reset.setPassword(pass_digest2);
                            merge(user_reset);
                            
                            //ENVIAR EL EMAIL
                            
                            
                            //FIN ENVIAR MAIL

                            

                        } catch (NoSuchAlgorithmException ex) {
                            Logger.getLogger(Controlador.class.getName()).log(Level.SEVERE, null, ex);
                        }
 
                    
                }
                
            session.removeAttribute("wrong_user");
            vista="/controlador/home";  
                
                
            break;
                
            case "/validarEmail" :
                String mailAUX = request.getParameter("emailValidar");
                TypedQuery<Usuarios> query4 = em.createNamedQuery("Usuarios.findByEmail", Usuarios.class);
                query4.setParameter("emailUnicidad", mailAUX);  
                List<Usuarios> result4= query4.getResultList();
                int malAUX;
                if(result4.isEmpty()){
                    session.setAttribute("malEmail", 1);
                    malAUX=0;
                }
                else{
                    session.setAttribute("malEmail", 0);
                    malAUX=1;
                }  
                vista="/WEB-INF/vistas/validarEmail.jsp?malEmail="+malAUX;
                break;
                
                
            // Otros case
            default:
                vista = "/controlador/home";
                break;
        }
        RequestDispatcher rd = request.getRequestDispatcher(vista);
        rd.forward(request, response);
             
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    public void persist(Object object) {
        try {
            utx.begin();
            em.persist(object);
            utx.commit();
        } catch (Exception e) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", e);
            throw new RuntimeException(e);
        }
    }

    public void merge(Object object) {
        try {
            utx.begin();
            em.merge(object);
            utx.commit();
        } catch (Exception e) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", e);
            throw new RuntimeException(e);
        }
    }
}
