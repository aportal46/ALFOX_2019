<%-- 
    Document   : ajax_delete
    Created on : 9 avr. 2019, 16:24:18
    Author     : snir2g2
--%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.persistence.Contrat"%>
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
    if (type.equals("contrat")) {
        
        String modele = request.getParameter("MContrat");
        String infos = request.getParameter("Cinfos");
        String vehiculeID = request.getParameter("Cimmatriculation");
        String zoneLimiteID = request.getParameter("CZoneLimite");
        String loueurID = request.getParameter("CLoueur");
        String numero = "C" + (Contrat.getLastID (con) + 1);
        Timestamp dateCreation = new Timestamp(System.currentTimeMillis());
        
        Contrat.create(
                con,
                numero,
                dateCreation,
                modele,
                infos,
                Integer.parseInt (loueurID),
                Integer.parseInt (vehiculeID),
                Integer.parseInt (zoneLimiteID)
        );
    }
    else if(type.equals("vehicule")){
        String marque = request.getParameter("Marque");
        String modele = request.getParameter("VModele");
        double compteurReel =  Double.parseDouble (request.getParameter("compteurR"));
        String immatriculation = request.getParameter("Immatriculation");
        String motorisation = request.getParameter("Motorisation");
        Timestamp datation = Utils.getDateDuJour();
        
        Timestamp dateVidange = Utils.stringToTimestamp(request.getParameter("Vdate").replace ('-', '/') + " 00:00:00");
        Timestamp dateControleTechnique = Utils.stringToTimestamp(request.getParameter("dateCT").replace ('-', '/') + " 00:00:00");
        Timestamp dateMiseEnService = Utils.stringToTimestamp(request.getParameter("dateMiseService").replace ('-', '/') + " 00:00:00");

        boolean horsZone = false;
        int tauxUtilisation = 0;
        boolean aProbleme = false;
        int kmVidange = 000;

        Vehicule.create(
                con,
                marque,
                modele,
                immatriculation,
                dateMiseEnService,
                motorisation,
                dateVidange,
                kmVidange,
                horsZone,
                tauxUtilisation,
                aProbleme,
                compteurReel,
                dateControleTechnique);
        Vehicule vehicule = Vehicule.getByImmatriculation(con, immatriculation);
        out.print(vehicule.getID(con));
        DonneesTR.create(con, "NORMAL",0, datation, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0, vehicule.getID(con));
        DonneesHisto.create(con, "NORMAL", datation, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, vehicule.getID(con));
    }
    else if(type.equals("loueur")){
        String nom = request.getParameter("LNom");
        String prenom = request.getParameter("LPrenom");
        String telephone = request.getParameter("phone");
        String mail = request.getParameter("LEmail");
        
        Loueur.create(con, nom, prenom, telephone, mail);
    }
%>