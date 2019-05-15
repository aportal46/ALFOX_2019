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
    
    // retourne par Ajax le type concerné
    String type = request.getParameter("type");
    if (type.equals("contrat")) {
       String infos = request.getParameter("infos");
       String zoneLimite = request.getParameter("ZoneLimite");
       String immatriculation = request.getParameter("Immatriculation");
       String numero = request.getParameter("numero");
              
       Vehicule v = Vehicule.getByImmatriculation(con, immatriculation);   
       Contrat c = Contrat.getByNumero(con, numero);
    
       c.setZoneLimiteID(Integer.parseInt(zoneLimite));
       c.setInfos(infos);
       c.setVehiculeID( v.getID(con));
       c.save(con);
    }
    else if(type.equals("vehicule")){
        String immatriculation = request.getParameter("Immatriculation");
        String dateVid = request.getParameter("dateVid").replace ('-', '/') + " 00:00:00";
        String dateCT = request.getParameter("dateCT").replace ('-', '/') + " 00:00:00";
        
        Vehicule v = Vehicule.getByImmatriculation(con, immatriculation);
        v.setDateVidange(dateVid);
        v.setDateControleTechnique(dateCT);
        v.save (con);
    }
    else if(type.equals("loueur")){
        String id = request.getParameter("id");
        String phone = request.getParameter("phone");
        String Email = request.getParameter("Email");
        
        Loueur l = Loueur.getById(con, Integer.parseInt (id));
        l.setMail(Email);
        l.setTelephone(phone);
        l.save(con);
        
    }
%>
