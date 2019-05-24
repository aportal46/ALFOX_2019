<%-- 
    Document   : ajax_getVehiculesTR
    Created on : 6 Juin 2018, 11:00:42
    Author     : snir2g1
    Description: retourne les infos pour un ou tous les vehicules :
                    immatriculation
                    mode
                    nbDefaut
                    position
                    compteur
                    consoMoy
                    vitesseMoy
                    regimeMoy
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.persistence.ConnexionMySQL"%>
<%@page import="com.persistence.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% // initialisation de la connexion à la BDD
    Connection con = (Connection) session.getAttribute("con");
    if (con == null) {
        con = ConnexionMySQL.newConnexion();
    }
    session.setAttribute("con", con);

    
    String immatriculation = request.getParameter("immatriculation");
    
    // retourne par Ajax les infos des véhicules ou du véhicule concerné
    if (immatriculation == null) {
        ArrayList<String> immatriculations = Vehicule.getImmatriculations(con);
        out.print("##");
        for (int i = 0; i < immatriculations.size(); i++) {
            Vehicule vehicule = Vehicule.getByImmatriculation(con, immatriculations.get(i));
            DonneesTR dtr = DonneesTR.getLastByImmatriculation(con, vehicule.getImmatriculation());
            /* immatriculation mode nbDefauts position compteur consoMoy vitesseMoy regimeMoy */
            out.print(vehicule.getImmatriculation() + "||" 
                + dtr.getMode() + "||"
                + dtr.getNbDefauts() + "||"
                + dtr.getLatitude() + "||" + dtr.getLongitude() + "||"
                + dtr.getDistanceParcourue() + "||"
                + dtr.getConsommation() + "||"
                + dtr.getVitesse() + "||"
                + dtr.getRegime() + "||"
                + dtr.getLatitudeGPS() + "||" + dtr.getLongitudeGPS()
            );
            out.print("##");
        }
    }
    else {
        Vehicule vehicule = Vehicule.getByImmatriculation(con, immatriculation);
        DonneesTR dtr = DonneesTR.getLastByImmatriculation(con, vehicule.getImmatriculation());
        /* immatriculation mode nbDefauts position compteur consoMoy vitesseMoy regimeMoy */
        out.print("||"
                + vehicule.getImmatriculation() + "||" 
                + dtr.getMode() + "||"
                + dtr.getNbDefauts() + "||"
                + dtr.getLatitude() + "||" + dtr.getLongitude() + "||"
                + dtr.getDistanceParcourue() + "||"
                + dtr.getConsommation() + "||"
                + dtr.getVitesse() + "||"
                + dtr.getRegime() + "||"
                + dtr.getLatitudeGPS() + "||" + dtr.getLongitudeGPS()
        );
    }
%>
