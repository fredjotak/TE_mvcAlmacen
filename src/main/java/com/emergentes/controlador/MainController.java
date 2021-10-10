package com.emergentes.controlador;

import com.emergentes.modelo.Producto;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession();
        
        if (sesion.getAttribute("listaProductos")==null) { // Si es la primera conexion
            sesion.setAttribute("listaProductos", new ArrayList<Producto>());
        }
        
        ArrayList<Producto> listaDeProductos = (ArrayList<Producto>)sesion.getAttribute("listaProductos");
        
        String op = request.getParameter("op");
        String opcion = (op!=null)? op: "vista";
        
        Producto producto = new Producto();
        int id, posicion;
        switch(opcion) {
            case "nuevo":
                request.setAttribute("miProducto", producto);
                request.getRequestDispatcher("editar.jsp").forward(request, response);
                break;
            case "editar":
                id = Integer.parseInt(request.getParameter("id"));
                posicion = buscarIndice(request, id);
                producto = listaDeProductos.get(posicion);
                request.setAttribute("miProducto", producto);
                request.getRequestDispatcher("editar.jsp").forward(request, response);
                break;
            case "eliminar":
                id = Integer.parseInt(request.getParameter("id"));
                posicion = buscarIndice(request, id);
                listaDeProductos.remove(posicion);
                sesion.setAttribute("listaProductos", listaDeProductos);
            case "vista":
                response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession();
        ArrayList<Producto> listaDeProductos = (ArrayList<Producto>)sesion.getAttribute("listaProductos");
        
        Producto producto = new Producto();
        
        producto.setId(Integer.parseInt(request.getParameter("hdnId")));
        producto.setDescripcion(request.getParameter("txtDescripcion"));
        producto.setCantidad(Integer.parseInt(request.getParameter("nroCantidad")));
        producto.setPrecio(Float.parseFloat(request.getParameter("nroPrecio")));
        
        int idActual = producto.getId();
        if (idActual==0){
            // Nuevo Producto
            int ultimoId = ultimoId(request);
            producto.setId(ultimoId);
            listaDeProductos.add(producto);
        } else  {
            // Actualizar un producto
            listaDeProductos.set(buscarIndice(request, idActual), producto);
        }
        
        sesion.setAttribute("listaProductos", listaDeProductos);
        response.sendRedirect("index.jsp");
    }
    
    private int buscarIndice(HttpServletRequest request, int id){
        HttpSession sesion = request.getSession();
        ArrayList<Producto> lista = (ArrayList<Producto>)sesion.getAttribute("listaProductos");
        int i = 0;
        if(lista.size()> 0){
            while(i<lista.size()){
                if(lista.get(i).getId() == id){
                    break;
                } else {
                    i++;
                }
            }
        }
        return i;
    }

    private int ultimoId(HttpServletRequest request){
        HttpSession sesion = request.getSession();
        ArrayList<Producto> lista = (ArrayList<Producto>)sesion.getAttribute("listaProductos");
        int idAux = 0;
        for(Producto prod: lista){
            idAux = prod.getId();
        }
        return idAux+1;
    }
}
