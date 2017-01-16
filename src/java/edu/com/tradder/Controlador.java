/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.com.tradder;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

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
        
        

        switch (accion) {
            case "/home":
                // Página Principal
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
                    }
                } catch (Exception e) {
                    System.err.println(e);
                    request.setAttribute("msg", "ERROR: imposible validar al usuario");
                }
                vista = "/index.jsp";
                break;
            case "/alta":
                // Mostrar el formulario de alta
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
                } catch (Exception e) {
                    request.setAttribute("msg", "ERROR: Usuario NO guardado");
                }
                vista = "/index.jsp";
                break;
                
            case "/articulos":
                     vista= "/ver_articulos.jsp";
                break;
            case "/interes":
                     vista= "/interes.jsp";
                break;   
                
            case "/logout":
                
                //
                session.removeAttribute("id");
                session.removeAttribute("user");
                request.setAttribute("msg", "Usuario desconectado");
                vista = "/index.jsp";
                break;
            case "/publicar":
                
                vista="/publicar.jsp";
                break;
            case "/validar_articulo":
                
                TypedQuery<Articulos> query;
                List<Articulos> lr;
                String msg = "";
                String idf;
                List<Articulos> lid;
                Articulos a;
                
                String cp = request.getParameter("cp");
                String year = request.getParameter("ano");
                String name = request.getParameter("name");
                String pvp = request.getParameter("precio");
                String categoria = request.getParameter("optionsRadios");
                String estado = request.getParameter("optionsRadios2");
                String descripcion = request.getParameter("descripcion");
                 
                //if (cp != null && year != null && name != null && pvp != null) {
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
                        msg = "<p class='error'>Error: Artículo " + name + " no creado</p>";
                    }
                /*} else {
                    System.out.println("Error: datos incorrectos");
                    msg = "<p class=\"error\">Error: Faltan datos</p>";
                }*/

               
                    
                vista = "/publicar.jsp";
                break;        
                
            // Otros case
            default:
                vista = "/index.jsp";
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

}
