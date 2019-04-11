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
    
    if (type.equals("contrat")) {
        Contrat.delete(con, id);
    }
    else if(type.equals("vehicule")){
        DonneesHisto.delete(con, id);
        Vehicule.delete(con, id);
    }
    else if(type.equals("loueur")){
        Loueur.delete(con, id);
    }
%>
