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
<script type="text/javascript" src="js/gestion.js"></script>
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
                    // recup la taile des bases de données
                    int nbV = Vehicule.size(con);
                    int nbC = Contrat.size(con);
                    int nbL = Loueur.size(con);

                    ArrayList<Loueur> listLoueurs = Loueur.getList(con);
                    ArrayList<Contrat> listContrats = Contrat.getList(con);
                    ArrayList<Vehicule> listVehicules = Vehicule.getList(con);
                    // recup l'immatriculation des véhicules
                    ArrayList<DonneesTR> donnees = DonneesTR.getByDate(con, vehicule.getImmatriculation(), "2018-03-20");
                    ArrayList<String> numero = Contrat.getNumeros(con);

                %>
                <%----   Script des Popups et selection de ligne  ----%>
                <div id="one" class="ui-body-d tablist-content">
                    <%---    btn d'ajout de contrat ----%>
                    <div id="btnAddContact" class="ui-nodisc-icon"><!-- Class added to the wrapper -->
                        <a href="#AddContactPop" data-rel="popup" class="ui-btn ui-shadow ui-corner-all ui-icon-plus ui-btn-icon-notext ui-btn-b ui-btn-inline" 
                           data-transition="pop" data-position-to="window"></a>
                        <div data-role="popup" id="AddContactPop" data-dismissible="false">
                            <div style="padding:10px 20px;">
                                <h3>Nouveau Contrat</h3>
                                <div class="ui-field-contain">
                                    <select name="Model" id="select-CLoueur">
                                        <option>Loueur</option>
                                        <%
                                            int index = 0;
                                            for (Loueur l : listLoueurs) {
                                        %><option value="<% out.print(index++); %>">
                                            <%
                                                    out.print(l.getPrenom() + " " + l.getNom());
                                                }
                                            %></option>
                                    </select>
                                </div>
                                <div class="ui-field-contain">
                                    <select name="MContrat" id="select-MContrat">
                                           <option>Modele Contrat</option>
                                           <option value="annuel">annuel</option>
                                           <option value="semi-annuel">semi-annuel</option>
                                           <option value="mensuelle">mensuelle</option>
                                    </select>
                                </div>
                                <label id="InfosContrat" for="un" class="ui-hidden-accessible">Infos</label>
                                <label for="infos">Infos</label>
                                <textarea name="infos" id="Cinfos"></textarea>
                                <div class="ui-field-contain">
                                    <select name="Model" id="select-CImmatricualtion">
                                        <option>Immatriculation</option>
                                        <%
                                            for (Vehicule v : listVehicules) {
                                        %><option value="<% out.print(v.getID(con)); %>"><%
                                                    out.print(v.getImmatriculation());
                                                }
                                            %>
                                        </option>
                                    </select>
                                </div>
                                <form>
                                    <div class="ui-field-contain">
                                        <select name="ZoneLimite" id="select-CZoneLimite">
                                              <option>Zone Limite</option>
                                              <option value="1">Zone 1</option>
                                              <option value="2">Zone 2</option>
                                              <option value="3">Zone 3</option>
                                        </select>
                                    </div>
                                </form>
                                <form data-theme="b" id="btn-popup">
                                    <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-theme="b">Annuler</a>
                                    <a href="CreateContrat" onclick="popupNvContrat.creerContrat ()" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-transition="flow" data-theme="b">Créer</a>
                                </form>
                            </div>
                        </div>
                    </div>
                    <%---- Tableau Contrat ----%> 
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
                                <th data-priority="8">&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody id="infosTR"><%// recup la liste des Contrat
                            for (Contrat c : listContrats) {
                                Loueur l = Loueur.getByContratID(con, c.getNumero());
                                Vehicule v = Vehicule.getByID(con, c.getVehiculeID());
                                out.print("<tr><td>" + c.getNumero());
                                out.print("<td>" + c.getDate());
                                out.print("<td>" + c.getType());
                                out.print("<td>" + c.getInfos());
                                out.print("<td>" + l.getPrenom());
                                out.print("<td>" + l.getNom());
                                out.print("<td>" + v.getImmatriculation());
                                out.print("<td>" + c.getZoneLimiteID());
                                out.print("<td>"); %>
                            <%----  Btn de Modification dans le tableau Contrat  ---%>
                        <div id="btnModifContrat<%out.print(c.getNumero());%>" class="ui-nodisc-icon"><!-- Class added to the wrapper -->
                            <%--- Btn de Modification du Contrat ---%>
                            <a href="#btnContratEdit<%out.print(c.getNumero());%>" data-rel="popup" data-position-to="window" 
                               class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-icon-edit ui-btn-icon-left ui-btn-a" 
                               data-transition="pop"></a>
                            <div data-role="popup" id="btnContratEdit<%out.print(c.getNumero());%>" data-theme="a" class="ui-corner-all" data-dismissible="false">
                                <div style="padding:10px 20px;">
                                    <h3>Modification</h3>
                                    <label for="Numero" disabled="disabled">Numéro de Contrat : <%  out.print(c.getNumero()); %></label>
                                    <div class="ui-field-contain">
                                        <select name="immatriculation" id="select-Immatricualtion">
                                            <option>Immatriculation</option>
                                            <%
                                                for (int mci = 0; nbV > mci; mci++) {
                                            %><option value="<% out.print(immatriculations.get(mci)); %>">
                                                <%
                                                        out.print(immatriculations.get(mci));
                                                    }
                                                %>
                                            </option>
                                        </select>
                                    </div>
                                    <div class="ui-field-contain">
                                        <select name="ZoneLimite" id="select-ZoneLimite">
                                               <option>Zone Limite</option>
                                               <option value="1">Zone 1</option>
                                              <option value="2">Zone 2</option>
                                               <option value="3">Zone 3</option>
                                        </select>
                                    </div>
                                    <label for="infos">Infos</label>
                                    <textarea name="infos" id="infos"></textarea>
                                    <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-theme="b">Annuler</a>
                                    <a href="EditContrat" onclick="popupEditContrat.EditContrat('<%out.print(c.getNumero()); %>')" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-transition="flow" data-theme="b">Modifier</a>
                                </div>
                            </div>
                            <%---- btn de Suppression de contrat-----%>
                            <a href="#popupDialog<%out.print(c.getNumero());%>" data-rel="popup" data-position-to="window" data-transition="pop" class="ui-btn ui-corner-all ui-shadow ui-btn-inline
                               ui-icon-delete ui-btn-i ui-btn-icon-left ui-btn-b"></a>
                            <div data-role="popup" id="popupDialog<%out.print(c.getNumero());%>" data-overlay-theme="b" data-theme="b" data-dismissible="false">
                                <div data-role="header" data-theme="b">
                                    <h1>Supprimer le contrat ?</h1>
                                </div>
                                <div role="main" class="ui-content" >
                                    <h3 class="ui-title">Est vous sur de vouloir supprimer le contrat ?</h3>
                                    <center>
                                        <label for="select-Loueur" disabled="disabled" >Loueur:<% out.print(l.getPrenom() + " " + l.getNom());  %> </label>
                                        <label for="Immatriculation" disabled="disabled"> Immatriculation: <% out.print(v.getImmatriculation());  %></label>
                                        <label for="Numero" disabled="disabled"> Numéro de Contrat : <%  out.print(c.getNumero()); %></label>
                                        <a href="#"  class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-theme="b">Non</a>
                                        <a href="#" onclick="deleteData('<%out.print(c.getNumero());%>', 'contrat')" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-transition="flow" data-theme="b">Oui</a>
                                    </center>
                                </div>
                            </div>
                        </div> <%
                            }
                        %>
                    </table>
                </div>
                <div id="two" class="ui-body-d tablist-content">
                    <%---- btn d'ajout des voitures ----%>
                    <div id="btnAddVehicule"class="ui-nodisc-icon"><!-- Class added to the wrapper -->
                        <a href="#AddVehiculePop"  data-rel="popup" data-position-to="window" data-transition="pop" class="ui-btn ui-shadow ui-corner-all 
                           ui-icon-plus ui-btn-icon-notext ui-btn-b ui-btn-inline"></a>
                        <div data-role="popup" id="AddVehiculePop" data-dismissible="false">
                            <div style="padding:10px 20px;">
                                <h3>Nouveaux véhicule</h3>
                                <label for="un" class="ui-hidden-accessible">Immatricualtion</label>
                                <label for="VImmatricualtion">Immatriculation</label>
                                <textarea name="VImmatriculation" id="VImmatriculation"></textarea>
                                <label for="un" class="ui-hidden-accessible">Marque</label>
                                <label for="VMarque">Marque</label>
                                <textarea name="VMarque" id="VMarque"></textarea>
                                <label for="un" class="ui-hidden-accessible">Modèle</label>
                                <label for="VModele">Modèle</label>
                                <textarea name="VModele" id="VModele"></textarea>
                                <label for="un" class="ui-hidden-accessible">Compteur réel</label>
                                <label for="un">Compteur Réel</label>
                                <input type="number" data-clear-btn="false" name="compteurR" id="compteurR" value="">
                                <label for="date">Date de mise en service:</label>
                                <input type="date" data-clear-btn="false" name="dateMiseService" id="dateMiseService" value="">
                                <label for="Vdate">Date de vidange:</label>
                                <input type="date" data-clear-btn="false" name="date" id="Vdate" value="">
                                <label for="date">Date du Control technique:</label>
                                <input type="date" data-clear-btn="false" name="dateCT" id="dateCT" value="">
                                <div class="ui-field-contain">
                                    <select name="Motorisation" id="select-Motorisation">
                                        <option>Motorisation</option>
                                        <option value="Diesel">Diesel</option>
                                        <option value="Essence">Essence</option>
                                    </select>
                                </div>
                                <div class="ui-field-contain">
                                    <form data-theme="b" id="btn-popup">
                                        <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-theme="b">Annuler</a>
                                        <a href="CreateVehicule" onclick="popupNvVehicule.creerVehicule()" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-transition="flow" data-theme="b">Créer</a> 
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%---- tableau Vehicule -----%>
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
                                <th data-priority="8">&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody id="infosTR"><%
                            // recup la liste des données tr et véhicules
                            for (Vehicule v : listVehicules) {
                                DonneesTR dtr = DonneesTR.getLastByImmatriculation (con, v.getImmatriculation());
                                //trie par immatriculation des vehicule
                                out.print("<tr><td>" + v.getImmatriculation() + "</td>");
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
                                out.print("<td>" + dtr.getDistanceParcourue() + " km" + "</td>");
                                out.print("<td>" + dtr.getVitesse() + " km/h" + "</td>");
                                out.print("<td>" + dtr.getConsommation() + " l/100" + "</td>");
                                out.print("<td>" + dtr.getRegimeMax() + "Tr/min");
                                out.print("<td>" + dtr.getDistanceParcourue() + " km");
                                out.print("<td>"); 
                            %>
                            <%---- btn de Suppression de véhicule-----%>
                        <a href="#BtnSupprV<%out.print(v.getImmatriculation ());%>" data-rel="popup" data-position-to="window" data-transition="pop" class="ui-btn ui-corner-all ui-shadow 
                           ui-btn-inline ui-icon-delete ui-btn-i ui-btn-icon-left ui-btn-b"></a>
                           <div data-role="popup" id="BtnSupprV<%out.print(v.getImmatriculation ());%>" data-overlay-theme="b" data-theme="b" data-dismissible="false">
                            <div data-role="header" data-theme="b">
                                <h1>Supprimer le véhicule ?</h1>
                            </div>
                            <div role="main" class="ui-content" >
                                <h3 class="ui-title">Est vous sur de vouloir supprimer le véhicule ?</h3>
                                <center>
                                    <label for="Immatriculation" disabled="disabled"> Immatriculation: <%out.print(v.getImmatriculation()); %></label>
                                    <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-theme="b">Non</a>
                                    <a href="#" onclick="deleteData('<%out.print(v.getImmatriculation());%>', 'vehicule')" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-transition="flow" data-theme="b">Oui</a>
                                </center>
                            </div>
                        </div>
                        <%----  Btn de Modification dans le tableau Véhicule  ---%>
                        <div id="btnModifVehicule"class="ui-nodisc-icon"><!-- Class added to the wrapper -->
                            <%--- Btn de Modification du Contrat ---%>
                            <a href="#btnVehiculeEdit" data-rel="popup" data-position-to="window" 
                               class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-icon-edit ui-btn-icon-left ui-btn-a" 
                               data-transition="pop"></a>
                            <div data-role="popup" id="btnVehiculeEdit" data-theme="a" class="ui-corner-all" data-dismissible="false">
                                <div style="padding:10px 20px;">
                                    <h3>Modification</h3>
                                    <label for="date">Date de vidange:</label>
                                    <input type="date" data-clear-btn="false" name="dateVid" id="dateVid" value="">
                                    
                                    <label for="date">Date du Control technique:</label>
                                    <input type="date" data-clear-btn="false" name="dateCT" id="dateCT" value="">
                                    
                                    <div class="ui-field-contain">
                                        <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-theme="b">Annuler</a>
                                        <a href="EditVehicule"  onclick="popupEditVehicule.EditVehicule()" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-transition="flow" data-theme="b">Modifier</a>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                                </tbody>
                                </table>
                            </div> 
                            <div id="three" class="ui-body-d tablist-content">
                                <%----- btn d'ajout d'utilisateurs ----%>
                                <div id="btnAddLoueur" class="ui-nodisc-icon"><!-- Class added to the wrapper -->
                                    <a href="#AddLoueurPop" data-rel="popup" class="ui-btn ui-shadow ui-corner-all ui-icon-plus ui-btn-icon-notext ui-btn-b ui-btn-inline"
                                       data-transition="pop" data-position-to="window"></a>
                                    <div data-role="popup" id="AddLoueurPop" data-dismissible="false">
                                        <form>
                                            <div style="padding:10px 20px;">
                                                <h3>Nouveau loueur</h3>
                                                <label for="Nom">Nom</label>
                                                <textarea name="Nom" id="LNom"></textarea>
                                                <label for="Nom">Prenom</label>
                                                <textarea name="Prenom" id="LPrenom"></textarea>
                                                <label for="Nom">E-mail</label>
                                                <textarea name="E-mail" id="LEmail" class="controle" type="mail" name="mail" required placeholder="mail@serveur.com" ></textarea>
                                                <div>
                                                    <label for="phone">N° de Télephone</label>
                                                    <input id="phone" type="number" pattern="[0-9]{2}[ \.\-]?[0-9]{2}[ \.\-]?[0-9]{2}[ \.\-]?[0-9]{2}[ \.\-]" placeholder="06.05.04.03.02">
                                                </div>
                                                <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-theme="b">Annuler</a>
                                                <a href="CreateLoueur" onclick="popupNvLoueur.creerLoueur()" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-transition="flow" data-theme="b">Créer</a>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <%---- Tableau des Loueurs ----%>
                                <table id="tabGestion" data-role="table" id="movie-table-custom" data-mode="reflow" class="table-stripe movie-list ui-responsive">
                                    <thead>
                                        <tr>
                                            <th data-priority="3">Nom</th>
                                            <th data-priority="2">Prenom</th>
                                            <th data-priority="4">e-mail</th>
                                            <th data-priority="5">N° de Téléphone</th>
                                            <th data-priority="6">N° Loueur</th>
                                            <th data-priority="8">&nbsp;</th>
                                        </tr>
                                    </thead>
                                    <tbody id="infosTR"><%
                                        // recup la liste des loueurs
                                        for (Loueur l : listLoueurs) {
                                            out.print("<tr><td>" + l.getNom());
                                            out.print("<td>" + l.getPrenom());
                                            out.print("<td>" + l.getMail());
                                            out.print("<td>" + l.getTelephone());
                                            out.print("<td>" + l.getID(con));
                                            out.print("<td>");
                                        %>
                                        <%----  Btn de Modification dans le tableau Loueur  ---%>
                                    <div id="btnModifLoueur"class="ui-nodisc-icon"><!-- Class added to the wrapper -->
                                        <%--- Btn de Modification du Loueur ---%>
                                        <a href="#btnLoueurEdit" data-rel="popup" data-position-to="window" 
                                           class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-icon-edit ui-btn-icon-left ui-btn-a" 
                                           data-transition="pop"></a>
                                        <div data-role="popup" id="btnLoueurEdit" data-theme="a" class="ui-corner-all" data-dismissible="false">
                                            <div style="padding:10px 20px;">
                                                <h3>Modification</h3>
                                                <label for="Nom">Nom</label>
                                                <textarea name="Nom" id="Nom"></textarea>
                                                <label for="Nom">Prenom</label>
                                                <textarea name="Prenom" id="Prenom"></textarea>
                                                <div>
                                                    <label class="EMail">Mail</label> 
                                                    <input id="Email" class="controle" type="mail" name="mail" required placeholder="mail@serveur.com">
                                                </div>
                                                <div>
                                                    <label for="phone">N° de Télephone</label>
                                                    <input id="phone" type="number" pattern="[0-9]{2}[ \.\-]?[0-9]{2}[ \.\-]?[0-9]{2}[ \.\-]?[0-9]{2}[ \.\-]" placeholder="06.05.04.03.02">
                                                </div>
                                                <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-theme="b">Annuler</a>
                                                <a href="EditLoueur" onclick="popupEditLoueur.EditLoueur()" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-transition="flow" data-theme="b">Modifier</a>
                                            </div>
                                        </div>
                                        <%---- btn de Suppression de Loueuer-----%>
                                        <a href="#BtnSupprL<%
                                            out.print(l.getID(con));
                                           %>" data-rel="popup" data-position-to="window" data-transition="pop" class="ui-btn ui-corner-all ui-shadow
                                           ui-btn-inline ui-icon-delete ui-btn-i ui-btn-icon-left ui-btn-b"></a>
                                        <div data-role="popup" id="BtnSupprL<%out.print(l.getID(con));%>" data-overlay-theme="b" data-theme="b" data-dismissible="false">
                                            <div data-role="header" data-theme="b">
                                                <h1>Supprimer le Loueur ?</h1>
                                            </div>
                                            <div role="main" class="ui-content" >
                                                <h3 class="ui-title">Est vous sur de vouloir supprimer le Loueur ?</h3>
                                                <center>
                                                    <label for="PLoueur" disabled="disabled"> <%out.print(l.getPrenom()); %></label>
                                                    <label for="NLoueur" disabled="disabled"> <% out.print(l.getNom()); %></label>
                                                    <label for="NumLoueur" disabled="disabled"> <% out.print(l.getID(con)); %></label>
                                                    <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-theme="b">Non</a>
                                                    <a href="#" onclick="deleteData('<%out.print(l.getID(con));%>', 'loueur')" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-transition="flow" data-theme="b">Oui</a>
                                                </center>
                                            </div>
                                        </div>
                                        <%}
                                        %>
                                        </tbody>
                                </table>
                            </div>
                        </div>
                        <%@include file="/includes/footer.jspf" %>
                </div>
                </body>
                </html>