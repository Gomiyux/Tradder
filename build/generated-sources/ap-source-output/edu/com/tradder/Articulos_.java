package edu.com.tradder;

import edu.com.tradder.Usuarios;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2017-01-17T23:40:52")
@StaticMetamodel(Articulos.class)
public class Articulos_ { 

    public static volatile SingularAttribute<Articulos, String> descripcion;
    public static volatile SingularAttribute<Articulos, String> precio;
    public static volatile SingularAttribute<Articulos, String> estado;
    public static volatile SingularAttribute<Articulos, Usuarios> propietario;
    public static volatile SingularAttribute<Articulos, String> categoria;
    public static volatile SingularAttribute<Articulos, Long> id;
    public static volatile SingularAttribute<Articulos, String> nombre;
    public static volatile SingularAttribute<Articulos, String> cp;
    public static volatile SingularAttribute<Articulos, String> año;

}