<%-- 
    Document    : gestion.jsp
    Description : page de gestion du parc par le responsable
    Created on  : Mars 2018
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.persistence.Vehicule"%>
<%@page import="com.persistence.DonneesTR"%>
<%@page import="com.persistence.ConnexionMySQL"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Acceuil</title> 
        <%@ include file="/includes/header.jspf" %>
    </head>
    <body>
        <%
            Connection con = (Connection) session.getAttribute("con");
            if (con == null) {
                con = ConnexionMySQL.newConnexion();
            }
            session.setAttribute("con", con);
        %>
        <div data-role="page" id="page1">
            <div class="header" data-role="header" data-id="main-header" data-tap-toggle="false" 
                 data-theme="a" data-position="fixed" data-fullscreen="true">
                <h1>
                    <img id="logoHeader" src="images/alcisLogo.png"/>
                    Gestion  
                    <form id="btnDeconnection" method="post" action="alfoxControl.jsp">
                        <input name="action" id="logout" type="hidden" value="logout"/>
                        <button type="submit" id="submitOK" name="submitOK">
                            <img id="white" src="css/themes/images/icons-png/power-white.png" >
                            <img id="black" src="css/themes/images/icons-png/power-black.png" >
                        </button>
                    </form>

                </h1>
            </div>
            <div role="main" class="ui-content">
                <center>
                    <br/><br/><br/><br/><br/>
                    <h1>Page de gestion du parc</h1>
                    <br/><br/><br/>
                </center>
            </div> 
            <div data-role="tabs" id="tabs">
                <div data-role="navbar">
                    <ul  class="tablist-left">
                        <li><a href="#one" data-ajax="false">Contrat</a></li>
                        <li><a href="#two" data-ajax="false">Véhicule</a></li>
                        <li><a href="#three" data-ajax="false">Loueur</a></li>
                    </ul>
                </div><%
                    ArrayList<String> immatriculations = Vehicule.getImmatriculations(con);
                    Vehicule vehicule = Vehicule.getByImmatriculation(con, immatriculations.get(0));
                    // recup l'immatriculation des véhicules
                    int nb = Vehicule.size(con);
                    ArrayList<DonneesTR> donnees = DonneesTR.getByDate(con, vehicule.getImmatriculation(), "2018-03-20");
                %><div id="one" class="ui-body-d tablist-content">
                    <table id="tabGestion" data-role="table" id="movie-table-custom" data-mode="reflow" class="table-stripe movie-list ui-responsive">
                        <thead>
                            <tr>
                                <th data-priority="1">N° Contrat</th>
                                <th data-priority="2">Date de Creation</th>
                                <th data-priority="3">Modele</th>
                                <th data-priority="4">Infos</th>
                                <th data-priority="5">loueur</th>
                                <th data-priority="4">Immatriculation</th>
                                <th data-priority="5">Zonne Limite</th>
                            </tr>
                        </thead>
                        <tbody id="infosTR"><%
                            // recup la liste des données tr pour ce véhicule et cette date
                            for (int i = 0; i < donnees.size(); i++) {
                                /*  out.print("<td>" + donnees.get(i).Ncontrat);
                                    out.print("<td>" + donnees.get(i).DateCreation);
                                    out.print("<td>" + donnees.get(i).cmodele);
                                    out.print("<td>" + donnees.get(i).infos);
                                    out.print("<td>" + donnees.get(i).prenom + donnees.get(i).nom);
                                    out.print("<td>" + immatriculations.get(i));
                                    out.print("<td>" + donnees.get(i).zonnelimiteID);*/
                            }
                            %></tbody>
                    </table>
                </div>
                   <div id="two" class="ui-body-d tablist-content"> 
                    <table id="tabGestion" data-role="table" id="movie-table-custom" data-mode="reflow" class="table-stripe movie-list ui-responsive">
                        <thead>
                            <tr>
                                <th data-priority="1">Numéro</th>
                                <th data-priority="2">Kilométrage</th>
                                <th data-priority="3">Vitesse Moyenne</th>
                                <th data-priority="4">Consommation Moyenne</th>
                                <th data-priority="5">Immatriculation</th>
                            </tr>
                        </thead>
                        <tbody id="infosTR"><%
                                // recup la liste des données tr pour ce véhicule et cette date
                                for (int i = 0; i < donnees.size(); i++) {
                                    out.print("<tr><td>" + i + "</td>");
                                    out.print("<td>" + donnees.get(i).getDistanceParcourue() + " km" + "</td>");
                                    out.print("<td>" + donnees.get(i).getVitesse() + " km/h" + "</td>");
                                    out.print("<td>" + donnees.get(i).getConsommation() + " l/100" + "</td>");
                                    out.print("<td>" + immatriculations.get(i));
                                }
                            %></tbody>
                    </table>
                </div>
                <div id="three" class="ui-body-d tablist-content">
                    <table id="tabGestion" data-role="table" id="movie-table-custom" data-mode="reflow" class="table-stripe movie-list ui-responsive">
                        <thead>
                            <tr>
                                <th data-priority="1">N° Contrat</th>
                                <th data-priority="2">Prenom</th>
                                <th data-priority="3">Nom</th>
                                <th data-priority="4">e-mail</th>
                                <th data-priority="5">N° de Téléphone</th>
                            </tr>
                        </thead>
                        <tbody id="infosTR"><%
                                // recup la liste des données tr pour ce véhicule et cette date
                                for (int i = 0; i < donnees.size(); i++) {
                                    /*  out.print("<td>" + donnees.get(i).Ncontrat);
                                    out.print("<td>" + donnees.get(i).prenom);
                                    out.print("<td>" + donnees.get(i).nom);
                                    out.print("<td>" + donnees.get(i).email);
                                    out.print("<td>" + donnees.get(i).numtel);*/
                                }
                            %></tbody>
                    </table>
                </div>
            </div>
            <%@include file="/includes/footer.jspf" %>
        </div>
    </body>
</html>