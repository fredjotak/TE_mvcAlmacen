<%@page import="java.util.ArrayList"%>
<%@page import="com.emergentes.modelo.Producto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList<Producto> listaProd = (ArrayList<Producto>)session.getAttribute("listaProductos");
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/styleGlobal.css">
        <link rel="stylesheet" href="css/style.css">
        <title>Inicio - Mi Almacen</title>
    </head>
    <body>
        <section>
            <h1 class="centro">Mi Almacen</h1>
            <a href="MainController?op=nuevo" class="boton fondo-naranja centro ancho-200p">Agregar Producto</a>
            <div class="contenedor-lista-img"><img src="css/producto.png"></div>
            <%
                if(listaProd!=null && listaProd.size()>0){
            %>
            <div class="contenedor-lista">
                <%
                    int contador = 0;
                    for(Producto item: listaProd){
                %>
                <div class="lista-detalle <%=(contador++%2==0)? "fondo-azul": "fondo-celeste"%>">
                    <p>
                        <b>id:</b> <%=item.getId()%> <br>
                        <b>descripcion:</b> <%=item.getDescripcion()%> <br>
                        <b>cantidad:</b> <%=item.getCantidad()%> unidades <br>
                        <b>precio:</b> <%=item.getPrecio()%> Bs.
                    </p>
                    <div class="lista-detalle-boton-2">
                        <a href="MainController?op=editar&id=<%=item.getId()%>" class="boton centro fondo-verde">Editar</a>
                        <a href="MainController?op=eliminar&id=<%=item.getId()%>" class="boton centro fondo-rojo" onclick="return confirm('Estas seguro de eliminar el producto <%=item.getDescripcion()%>');">Eliminar</a>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
            <%
                } else {
            %>
            <p class="alerta fondo-rojo centro">No hay Productos en el almacén. Registre <a href="MainController?op=nuevo">aqui</a>.</p>
            <%
                }
            %>
        </section>
         <footer>
            © 2021 - Todos los derechos reservados
        </footer>
    </body>
</html>
