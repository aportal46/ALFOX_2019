<%-- 
    Document   : ajax_delete
    Created on : 9 avr. 2019, 16:24:18
    Author     : snir2g2
--%>

<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.persistence.ConnexionMySQL"%>
<%@page import="com.persistence.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% // initialisation de la connexion à la BDD
    Connection con = (Connection) session.getAttribute("con");
    if (con == null)
        con = ConnexionMySQL.newConnexion();
    session.setAttribute("con", con);
    
    // retourne par Ajax l'ID du contrat concerné
    String id = request.getParameter("id");
    String type = request.getParameter("type"); 
    
    if(type.equals("contrat")){
        Contrat.delete(con, id);
    }
    else if(type.equals("vehicule")){
        Vehicule vehicule = Vehicule.getByImmatriculation(con, id);
        Contrat contrat = Contrat.getByVehiculeID(con, vehicule.getID(con));
        String vehiculeID = Integer.toString(vehicule.getID(con));
        if(contrat == null){
            DonneesHisto.delete(con, vehiculeID);
            DonneesTR.delete(con, vehiculeID);
            Vehicule.delete(con, id);
        }else{
            out.print("le vehicule à un contrat");
        }
    }else if(type.equals("loueur")){
        Contrat contrat = Contrat.getByLoueurID(con, Integer.parseInt(id));
        if(contrat == null){
            Loueur.delete(con, id);
        }else{ 
            out.print("le loueur à un contrat");
        }        
    }else{
        out.print("end");
    }
%>