<%-- 
    Document    : gestion.jsp
    Description : page de gestion du parc par le responsable
    Created on  : Mars 2018
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.persistence.Vehicule"%>
<%@page import="com.persistence.DonneesTR"%>
<%@page import="com.persistence.Loueur"%>
<%@page import="com.persistence.Contrat"%>
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
                </div>
                <%
                    ArrayList<String> immatriculations = Vehicule.getImmatriculations(con);
                    Vehicule vehicule = Vehicule.getByImmatriculation(con, immatriculations.get(0));
                    // recup l'immatriculation des véhicules
                    int nbV = Vehicule.size(con);
                    int nbC = Contrat.size(con);
                    int nbL = Loueur.size(con);
                    ArrayList<DonneesTR> donnees = DonneesTR.getByDate(con, vehicule.getImmatriculation(), "2018-03-20");

                    ArrayList<String> numero = Contrat.getNumeros(con);

                    /* ArrayList<String> ID = Loueur.getIDs(con); */
                %>

                <div id="one" class="ui-body-d tablist-content">
                    <scrip file="/js/gestion.js" >
                        <div id="btnAddContact" class="ui-nodisc-icon"><!-- Class added to the wrapper -->
                            <a href="#AddContactPop" data-rel="popup" class="ui-btn ui-shadow ui-corner-all ui-icon-plus ui-btn-icon-notext ui-btn-b ui-btn-inline" data-transition="pop">Plus</a>
                           <div data-role="popup" id="AddContactPop">
                                
                            </div>
                        </div>
                    </scrip>
                    <table id="tabGestion" data-role="table" id="movie-table-custom" data-mode="reflow" class="table-stripe movie-list ui-responsive">
                        <thead>
                            <tr>
                                <th data-priority="1">N° Contrat</th>
                                <th data-priority="2">Date de Création</th>
                                <th data-priority="3">Modèle</th>
                                <th data-priority="4">Infos</th>
                                <th data-priority="5">Prénom</th>
                                <th data-priority="6">Nom</th>
                                <th data-priority="7">Immatriculation</th>
                                <th data-priority="8">Zone Limite</th>
                                <th data-priority="8">  |  </th>
                            </tr>
                        </thead>
                        <tbody id="infosTR"><%                            // recup la liste des Contrat
                            for (int i = 0; i < nbC; i++) {
                                Contrat c = Contrat.getByNumero(con, numero.get(i));
                                /*Loueur l = Loueur.getByID(con, ID.get(i));*/
                                out.print("<tr><td>" + c.getNumero());
                                out.print("<td>" + c.getDate());
                                out.print("<td>" + c.getType());
                                out.print("<td>" + c.getInfos());
                                out.print("<td>" + "prenom");
                                out.print("<td>" + "nom");
                                out.print("<td>" + immatriculations.get(i));
                                out.print("<td>" + c.getZoneLimiteID());
                                out.print("<td>"); %>
                                <div id="btnModifContrat"class="ui-nodisc-icon"><!-- Class added to the wrapper -->
                                    <a href="
                                    <%  out.print(i);
                                    %>
                                       " class="ui-btn ui-shadow ui-corner-all ui-icon-edit ui-btn-icon-notext ui-btn-b ui-btn-inline">Plus</a>
                                    <a href= "#" class="ui-btn ui-shadow ui-corner-all ui-icon-delete ui-btn-icon-notext ui-btn-b ui-btn-inline">Plus</a>
                                </div> <% 
                            }
                            %>
                    </table>
                </div>
                   <div id="two" class="ui-body-d tablist-content"> 
                    <div id="btnAddVehicule"class="ui-nodisc-icon"><!-- Class added to the wrapper -->
                        <a href="#" class="ui-btn ui-shadow ui-corner-all ui-icon-plus ui-btn-icon-notext ui-btn-b ui-btn-inline">Plus</a>
                    </div>
                    <table id="tabGestion" data-role="table" id="movie-table-custom" data-mode="reflow" class="table-stripe movie-list ui-responsive">
                        <thead>
                            <tr>
                                <th data-priority="1">Immatriculation</th>
                                <th data-priority="2">Marque</th>
                                <th data-priority="3">Modele</th>
                                <th data-priority="4">Date Mise en Service</th>
                                <th data-priority="5">Motorisation</th>
                                <th data-priority="6">Date de Vidange</th>
                                <th data-priority="7">Km Vidange</th>
                                <th data-priority="8">Hors Zone</th>
                                <th data-priority="9">Taux d'utilisation</th>
                                <th data-priority="10">AProbleme</th>
                                <th data-priority="11">Compteur Reel</th>
                                <th data-priority="12">Date CT</th>
                                <th data-priority="13">Kilométrage</th>
                                <th data-priority="14">Vitesse Moyenne</th>
                                <th data-priority="15">Consommation Moyenne</th>
                                <th data-priority="16">Régime</th>
                                <th data-priority="17">Compteur KM</th>
                            </tr>
                        </thead>
                        <tbody id="infosTR"><%
                            // recup la liste des données tr et véhicules
                            for (int i = 0; i < nbV; i++) {
                                Vehicule v = Vehicule.getByImmatriculation(con, immatriculations.get(i));
                                out.print("<tr><td>" + immatriculations.get(i) + "</td>");
                                out.print("<td>" + v.getMarque());
                                out.print("<td>" + v.getModele());
                                out.print("<td>" + v.getDateMiseEnService());
                                out.print("<td>" + v.getMotorisation());
                                out.print("<td>" + v.getDateVidange());
                                out.print("<td>" + v.getKmVidange());
                                out.print("<td>" + v.getHorsZone());
                                out.print("<td>" + v.getTauxUtilisation());
                                out.print("<td>" + v.getAProbleme());
                                out.print("<td>" + v.getCompteurReel());
                                out.print("<td>" + v.getDateControleTechnique());
                                out.print("<td>" + donnees.get(i).getDistanceParcourue() + " km" + "</td>");
                                out.print("<td>" + donnees.get(i).getVitesse() + " km/h" + "</td>");
                                out.print("<td>" + donnees.get(i).getConsommation() + " l/100" + "</td>");
                                out.print("<td>" + donnees.get(i).getRegimeMax() + "Tr/min");
                                out.print("<td>" + donnees.get(i).getDistanceParcourue() + " km");
                           
                            }
                            %></tbody>
                    </table>
                </div> 
                <div id="three" class="ui-body-d tablist-content">
                    <div id="btnAdLoueur"class="ui-nodisc-icon"><!-- Class added to the wrapper -->
                        <a href="#" class="ui-btn ui-shadow ui-corner-all ui-icon-plus ui-btn-icon-notext ui-btn-b ui-btn-inline">Plus</a>
                    </div>
                    <table id="tabGestion" data-role="table" id="movie-table-custom" data-mode="reflow" class="table-stripe movie-list ui-responsive">
                        <thead>
                            <tr>
                                <th data-priority="3">Nom</th>  
                                <th data-priority="2">Prenom</th>
                                <th data-priority="4">e-mail</th>
                                <th data-priority="5">N° de Téléphone</th>
                            </tr>
                        </thead>
                        <tbody id="infosTR"><%
                            // recup la liste des loueurs
                            for (int i = 0; i < nbL; i++) {
                                /*   Contrat c = Contrat.getByNumero(con, numero.get(i));
                                    Loueur l = Loueur.getByID(con, ID.get(i));
                                    out.print("<td>" + l.getNom());
                                    out.print("<td>" + l.getPrenom());
                                    out.print("<td>" + l.getMail());
                                    out.print("<td>" + l.getTelephone());*/
                            }
                            %></tbody>
                    </table>
                </div>
            </div>
            <%@include file="/includes/footer.jspf" %>
        </div>
    </body>
</html>