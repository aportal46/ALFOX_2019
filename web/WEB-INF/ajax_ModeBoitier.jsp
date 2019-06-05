<%-- 
    Document   : ajax_ModeBoitier
    Created on : 4 juin 2019, 13:47:33
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
    String type = request.getParameter("type"); 
    String msg = "";
    
    if (type.equals("DORMIR")) {
       msg = MessageManager.nouveauMode(6);
    }
    else if(type.equals("GPS")){
        msg = MessageManager.nouveauMode(3);
    }
    else if(type.equals("DemandeGPS")){
        msg = MessageManager.nouveauMode(2);
    }
    else if(type.equals("RESET")){
        msg = MessageManager.nouveauMode(5);
    }
    else if(type.equals("NORMAL")){
       msg = MessageManager.nouveauMode(0);
    }
    
    if( ! MessageManager.demandEnvoye(msg)){
        //TODO : gestion d'erreurs à faire.
    }
%>