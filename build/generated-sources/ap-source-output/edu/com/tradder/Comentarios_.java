package edu.com.tradder;

import edu.com.tradder.Articulos;
import edu.com.tradder.Usuarios;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2017-01-26T23:55:25")
@StaticMetamodel(Comentarios.class)
public class Comentarios_ { 

    public static volatile SingularAttribute<Comentarios, String> texto;
    public static volatile SingularAttribute<Comentarios, Long> id;
    public static volatile SingularAttribute<Comentarios, Articulos> articulo;
    public static volatile SingularAttribute<Comentarios, Usuarios> autor;
    public static volatile SingularAttribute<Comentarios, String> privacidad;

}