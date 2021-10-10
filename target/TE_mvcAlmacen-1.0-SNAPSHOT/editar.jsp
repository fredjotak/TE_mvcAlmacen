<%@page import="com.emergentes.modelo.Producto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Producto producto = (Producto) request.getAttribute("miProducto");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/styleGlobal.css">
        <link rel="stylesheet" href="css/style.css">
        <title><%=(producto.getId()==0)? "Nuevo": "Editar"%> Producto</title>
    </head>
    <body>
        <section>
            <div class="contenedor-formulario">
                <h1 class="formulario-titulo"><%=(producto.getId()==0)? "Nuevo": "Editar"%> Producto</h1>
                <div class="formulario-logo"><img src="css/producto.png" alt=""></div>
                <form action="MainController" method="POST" class="formulario fondo-naranja">
                    <div class="formulario-campos">
                        <input type="hidden" name="hdnId" value="<%=producto.getId()%>">
                        <label for="txtDescripcion">Descripcion:</label>
                        <input type="text" id="txtDescripcion" name="txtDescripcion" value="<%=producto.getDescripcion()%>" required>
                        <br>
                        <label for="nroCantidad">Cantidad:</label>
                        <input type="number" id="nroCantidad" name="nroCantidad" min="0" step="1" value="<%=producto.getCantidad()%>" required>
                        <br>
                        <label for="nroPrecio">Precio:</label>
                        <input type="number" id="nroPrecio" name="nroPrecio" required step=".1" min=".1" value="<%=producto.getPrecio()%>" required>
                    </div>
                    <input class="boton" type="submit" value="<%=(producto.getId()==0)? "Registrar": "Actualizar"%>">
                </form>
            </div>
        </section>
        <footer>
            © 2021 - Todos los derechos reservados
        </footer>
    </body>
</html>
