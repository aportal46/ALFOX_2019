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
    
    // retourne par Ajax les types actuelles et demandés
    String acType = request.getParameter("acType");
    String type = request.getParameter("type");
    String msg = "";
    
    if (type == "DORMIR" && acType != type){
       msg = MessageManager.nouveauMode(6);
    }
    else if(type == "GPS" && acType != type){
        msg = MessageManager.nouveauMode(3);
    }
    else if(type == "DemandeGPS" && acType != type){
        msg = MessageManager.nouveauMode(2);
    }
    else if(type == "RESET" && acType != type){
        msg = MessageManager.nouveauMode(5);
    }
    else if(type == "NORMAL" && acType != type){
       msg = MessageManager.nouveauMode(0);
    }
    
    if( ! MessageManager.demandEnvoye(msg)){
        //TODO : gestion d'erreurs à faire.
    }
%>