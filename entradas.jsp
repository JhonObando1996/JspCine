<%-- 
    Document   : index
    Created on : 15 oct. 2020, 14:22:09
    Author     : jhon Obando
--%>

<%!
    int filasCine=6;
    int columnasCine=10;
    int correlativo=1000;
    
    String asientos[][]= new String[filasCine][columnasCine];
    

    private String comprarAsientos(int fila, int cantidad, boolean juntos){
        int f=fila-1;
        String ticket="TCK-" + correlativo;
        if(juntos){
        
        int disponibles = 0;
        int max=0;

        for(int c = 0; c<columnasCine; c++){
            if(asientos[f][c] == null){
                    disponibles++;
                }else{
                    disponibles=0;
                    }
                        if(disponibles >= cantidad){
                            for(int x=0; x<cantidad;x++){
                                asientos[f][c-x]=ticket;
                        }
                    }
                    correlativo++;
                    return "Venta Finalizada. Ticket: " + ticket;
                }
                
            
            }else{
            int cont=0;
            int pos=0;
            
            while(cont < cantidad){
                if(asientos[f][pos]==null){
                    asientos[f][pos]=ticket;
                    cont++;
                    }
                    pos++;
                }
                correlativo++;
            }
            
            return "Venta Finalizada. Ticket: " + ticket;
        }
    
    private int contarAsientosDisponibles(int fila, boolean juntos){
       
        int f= fila-1;
        int disponibles = 0;
        int max=0;

        for(int c = 0; c<columnasCine; c++){
            if(asientos[f][c] == null){
                    disponibles++;
                }else{
                    if(juntos){
                        if(disponibles >max){
                            max=disponibles;
                            disponibles=0;
                            
                        }
                    }
                }
                
            }

            if(juntos){
                        if(disponibles >max){
                            max=disponibles;
                            disponibles=0;
                            
                        }
                            disponibles=max;
                    }
        
        return disponibles;

}
    
 %>
   
 
 <%
     asientos[0][0]="RESERVADO";
     asientos[0][1]="RESERVADO";
     asientos[0][2]="RESERVADO";
     asientos[0][5]="RESERVADO";
     asientos[1][5]="RESERVADO";
     asientos[1][6]="RESERVADO";
     asientos[1][7]="RESERVADO";
     asientos[3][2]="RESERVADO";
     

     String sFila = request.getParameter("fila");
     String sCantidad = request.getParameter("cantidad");
     String sJuntos = request.getParameter("juntos");
     String nombre = request.getParameter("nombre");
 
     String mensaje="";
     try {
          int fila = Integer.parseInt(sFila);
          int cantidad = Integer.parseInt(sCantidad);
          boolean juntos=true;
          if(sJuntos == null)juntos = false;
          
          int disponibleFila=contarAsientosDisponibles(fila, juntos);
          mensaje="Disponibles : " + disponibleFila;
          
          if(disponibleFila >= cantidad){
               mensaje= comprarAsientos(fila, cantidad, juntos);
          
            }else{
            
                mensaje="No hay " + cantidad + " de asientos disponibles en la fila " + fila;
                }
          
         } catch (Exception e) {
         mensaje="Debe ingresar un numero";
     }

     if(sFila == null) sFila ="";
     if(sCantidad == null) sCantidad ="";
     if(nombre == null) nombre ="";
 %>
    
    
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cine UG</title>
    </head>
    <body>
        <table border="0" width="1024">
            <tr>
                <td>
                    <table width="100%" border="0">
                        <tr>
                            <td><img src="img/UGlogo.png" width="200"></td>
                            <td>Cinema UG <br> Aprende mirando</td>
                        </tr>
                    </table>
                </td>
            </tr>
            
            <tr>
                <td>
                    <table width="100%" border="0" cellpading="10" cellspaciing="5">
                        <tr bgcolor="#D5DBDB">
                            <td><a href="index.jsp">Home</a></td>
                            <td><a href="peliculas.jsp">Peliculas</a></td>
                            <td bgcolor="#566573"><font color="white">Compra de Entradas </font></a></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table border="1" width="100%">
                        <tr>
                            <td width="40%">
                                <!<!-- FORMULARIO -->
                                <table>
                                    <tr>
                                    <h3>Compra de Entradas</h3>
                                    <p> Seleccione el numero de la fila que desea la entada y cuantas entradas desea.
                                        El sistema tratara de ubicarlo en la fila si existe disponible la cantidad
                                        de asientos descupados contiguos
                                    </tr>
                                    <tr>
                                        <td>
                                            <fieldset>
                                                <form method="POST" action="">
                                                <table width="100%" cellspacing="5" cellpading="5">
                                                    <tr>
                                                        <td width="30%" aling="rigth">Fila:</td>
                                                        <td><input type="text" name="fila" value="<%= sFila %>"></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="30%" aling="rigth">Cantidad Asientos:</td>
                                                        <td><input type="text" name="cantidad" value="<%= sCantidad %>"></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="30%" aling="rigth">Nombre:</td>
                                                        <td><input type="text" name="nombre" value="<%= nombre %>"></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="30%" aling="rigth">&nbsp;</td>
                                                        <td><input type="checkbox" name="juntos" value="1">Asientos Juntos</td>
                                                    </tr>
                                                    <tr>
                                                        
                                                        <td colspan="2"><input type="submit"  value="Comprar Entradas"></td>
                                                    </tr>
                                                    
                                                </table>
                                                </form>
                                            </fieldset>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="60%" align="center" valign="top">
                                <table border="0" width="90%">
                                <% for(int f=0; f<filasCine;f++){%>
                                    <tr>
                                        <th bgcolor="#566573" width="10%"><%=(f+1)%></th>
                                    <% for(int c=0; c<columnasCine;c++){%>
                                    <% if(asientos[f][c]==null){%>
                                        <th width="9%"><img src="img/asientoLibre.png" width="30"/></th>
                                        
                                    <% } else{%>
                                    <th width="9%"><img src="img/asientoOcupado.png" width="30" title="<%= asientos[f][c] %>"/></th>
                                    <% } %>
                                    <% } %>
                                    </tr>
                                 <% } %>
                                 <tr>
                                     <td colspan="5" align="center"><img src="img/asientoLibre.png" width="15%" /><br>Asiento Libre</td>
                                     <td colspan="6" align="center"><img src="img/asientoOcupado.png" width="15%""/><br>Asiento Ocupado</td>
                                 </tr>
                                 </table>
                                 <h3><%=mensaje%></h3>
                                  
                            </td>
                        </tr>
                        
                    </table>
                </td>
            </tr>
           
            
            <tr>
                <th bgcolor="#D5DBDB"><h4>Todos los derechos reservados @ Jhon Obando</h4></th>
            </tr>
            
            
        </table>
    </body>
</html>
