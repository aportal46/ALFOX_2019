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
                    // recup la taile des bases de données
                    int nbV = Vehicule.size(con);
                    int nbC = Contrat.size(con);
                    int nbL = Loueur.size(con);
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
                                            <select name="Loueur" id="select-Loueur">
                                                   <option>Loueur</option>
                                                   <option value="1">Loueur A</option>
                                                   <option value="2">Loueur B</option>
                                                   <option value="3">Loueur C</option>
                                            </select>
                                        </div>
                                        <div class="ui-field-contain">
                                            <select name="MContrat" id="select-MContrat">
                                                   <option>Modele Contrat</option>
                                                   <option value="1">annuel</option>
                                                   <option value="2">semi-annuel</option>
                                                   <option value="3">mensuelle</option>
                                            </select>
                                        </div>
                                        <label for="un" class="ui-hidden-accessible">Infos</label>
                                        <label for="infos-1">Infos</label>
                                        <textarea name="infos-1" id="infos-1"></textarea>
                                            <div class="ui-field-contain">
                                                <select name="Model" id="select-Immatricualtion">
                                                    <option>Immatriculation</option>
                                        <%                                            for (int i = 0; nbV > i; i++) {
                                        %><option value="
                                                <% out.print(i); %>
                                                ">
                                            <%
                                                    out.print(immatriculations.get(i));
                                                }
                                            %>
                                        </option>
                                                </select>
                                            </div>
                                        <form>
                                            <div class="ui-field-contain">
                                                <select name="ZoneLimite" id="select-ZoneLimite">
                                                      <option>Zone Limite</option>
                                                      <option value="1">Zone 1</option>
                                                      <option value="2">Zone 2</option>
                                                      <option value="3">Zone 3</option>
                                                </select>
                                            </div>
                                        </form>
                                        <form data-theme="b" id="btn-popup">
                                            <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-theme="b">Annuler</a>
                                            <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-transition="flow" data-theme="b">Créer</a>
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
                                for (int i = 0; i < nbC; i++) {

                                    Contrat c = Contrat.getByNumero(con, numero.get(i));;
                                    out.print("<tr><td>" + c.getNumero());
                                    out.print("<td>" + c.getDate());
                                    out.print("<td>" + c.getType());
                                    out.print("<td>" + c.getInfos());
                                    out.print("<td>" + "prenom");
                                    out.print("<td>" + "nom");
                                    out.print("<td>" + immatriculations.get(i));
                                    out.print("<td>" + c.getZoneLimiteID());
                                    out.print("<td>"); %>
                                <%----  Btn de Modification dans le tableau Contrat  ---%>
                            <div id="btnModifContrat"class="ui-nodisc-icon"><!-- Class added to the wrapper -->
                                <%--- Btn de Modification du Contrat ---%>
                                <a href="#btnContratEdit" data-rel="popup" data-position-to="window" 
                                   class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-icon-edit ui-btn-icon-left ui-btn-a" 
                                   data-transition="pop"></a>
                                <div data-role="popup" id="btnContratEdit" data-theme="a" class="ui-corner-all" data-dismissible="false">
                                        <div style="padding:10px 20px;">
                                            <h3>Modification</h3>
                                                <div class="ui-field-contain">
                                                    <select name="immatriculation" id="select-Immatricualtion">
                                                        <option>Immatriculation</option>
                                            <%
                                                for (int mci = 0; nbV > mci; mci++) {
                                            %><option value="<% out.print(mci); %>">
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
                                            <label for="infos-1">Infos</label>
                                            <textarea name="infos-1" id="infos-1"></textarea>
                                            <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-theme="b">Annuler</a>
                                            <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-transition="flow" data-theme="b">Modifier</a>
                                        </div>
                                </div>
                                <%---- btn de Suppression de contrat-----%>
                                <a href="#popupDialog" data-rel="popup" data-position-to="window" data-transition="pop" class="ui-btn ui-corner-all ui-shadow ui-btn-inline
                                   ui-icon-delete ui-btn-i ui-btn-icon-left ui-btn-b"></a>
                                <div data-role="popup" id="popupDialog" data-overlay-theme="b" data-theme="b" data-dismissible="false">
                                    <div data-role="header" data-theme="b">
                                        <h1>Supprimer le contrat ?</h1>
                                    </div>
                                    <div role="main" class="ui-content" >
                                        <h3 class="ui-title">Est vous sur de vouloir supprimer le contrat ?</h3>
                                        <center>
                                            <label for="prenom" disabled="disabled" >Loueur: Jean Bon</label>
                                            <label for="Immatriculation" disabled="disabled"> Immatriculation: ED-4886-FD</label>
                                            <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-theme="b">Non</a>
                                            <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-transition="flow" data-theme="b">Oui</a>
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
                                    <label for="Immatricualtion-1">Immatriculation</label>
                                    <textarea name="Immatriculation-1" id="Immatriculation-1"></textarea>
                                    <label for="un" class="ui-hidden-accessible">Marque</label>
                                    <label for="Marque-1">Marque</label>
                                    <textarea name="Marque-1" id="Marque-1"></textarea>
                                    <label for="un" class="ui-hidden-accessible">Modèle</label>
                                    <label for="Modele-1">Modèle</label>
                                    <textarea name="Modele-1" id="Modele-1"></textarea>
                                    <label for="date-1">Date de vidange:</label>
                                    <input type="date" data-clear-btn="false" name="date-1" id="date-1" value="">
                                    <label for="date-1">Date du Control technique:</label>
                                    <input type="date" data-clear-btn="false" name="dateCT-1" id="dateCT-1" value="">
                                    <div class="ui-field-contain">
                                        <select name="Motorisation" id="select-Motorisation">
                                            <option>Motorisation</option>
                                            <option value="1">Diesel</option>
                                            <option value="2">Essence</option>
                                        </select>
                                    </div>
                                    <div class="ui-field-contain">
                                        <form data-theme="b" id="btn-popup">
                                            <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-theme="b">Annuler</a>
                                            <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-transition="flow" data-theme="b">Créer</a> 
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
                                for (int i = 0; i < nbV; i++) {
                                    //trie par immatriculation des vehicule
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
                                    out.print("<td>"); %>
                                <%---- btn de Suppression de véhicule-----%>
                            <a href="#BtnSupprV" data-rel="popup" data-position-to="window" data-transition="pop" class="ui-btn ui-corner-all ui-shadow 
                               ui-btn-inline ui-icon-delete ui-btn-i ui-btn-icon-left ui-btn-b"></a>
                            <div data-role="popup" id="BtnSupprV" data-overlay-theme="b" data-theme="b" data-dismissible="false">
                                <div data-role="header" data-theme="b">
                                    <h1>Supprimer le véhicule ?</h1>
                                </div>
                                <div role="main" class="ui-content" >
                                    <h3 class="ui-title">Est vous sur de vouloir supprimer le véhicule ?</h3>
                                    <center>
                                        <label for="Immatriculation" disabled="disabled"> Immatriculation: ED-4886-FD</label>
                                        <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-theme="b">Non</a>
                                        <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-transition="flow" data-theme="b">Oui</a>
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
                                                <div class="ui-field-contain">
                                                </div>
                                                <div class="ui-field-contain">
                                                    <select name="ZoneLimite" id="select-ZoneLimite">
                                                           <option>Zone Limite</option>
                                                           <option value="1">Zone 1</option>
                                                          <option value="2">Zone 2</option>
                                                           <option value="3">Zone 3</option>
                                                    </select>
                                                </div>
                                            <label for="infos-1">Infos</label>
                                            <textarea name="infos-1" id="infos-1"></textarea>
                                            <label for="date-1">Date de vidange:</label>
                                            <input type="date" data-clear-btn="false" name="date-1" id="date-1" value="">
                                            <label for="date-1">Date du Control technique:</label>
                                            <input type="date" data-clear-btn="false" name="dateCT-1" id="dateCT-1" value="">
                                            <div class="ui-field-contain">
                                                <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-theme="b">Annuler</a>
                                                <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-transition="flow" data-theme="b">Modifier</a>
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
                                        <h3>Nouveau Contrat</h3>
                                        <label for="Nom">Nom</label>
                                        <textarea name="Nom" id="Prenom"></textarea>
                                        <label for="Nom">Prenom</label>
                                        <textarea name="Prenom" id="Prenom"></textarea>
                                        <label for="Nom">E-mail</label>
                                        <textarea name="E-mail" id="E-mail"></textarea>
                                        <label for="NTel">N° de Téléphone</label>
                                        <textarea name="NTel" id="NTel"></textarea>
                                        <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-theme="b">Annuler</a>
                                        <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-transition="flow" data-theme="b">Créer</a>
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
                                    <th data-priority="8">&nbsp;</th>
                                </tr>
                            </thead>
                            <tbody id="infosTR"><%
                                // recup la liste des loueurs
                                for (int i = 0; i < nbL; i++) {
                                    Loueur l = Loueur.getById(con, i+1);
                                    out.print("<tr><td>" + l.getNom());
                                            out.print("<td>" + l.getPrenom());
                                            out.print("<td>" + l.getMail());
                                    out.print("<td>" + l.getTelephone());
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
                                            <textarea name="Nom" id="Prenom"></textarea>
                                            <label for="Nom">Prenom</label>
                                            <textarea name="Prenom" id="Prenom"></textarea>
                                            <div>
                                                <label class="Mail">Mail</label> 
                                                <input class="controle" type="email" name="mail" required placeholder="mail@serveur.com"> 
                                                <span class="resultat"></span>
                                            </div>
                                            <div>
                                                <label for="phone">N° de Télephone</label>
                                                    <input id="phone" type="number" pattern="[0-9]{2}[ \.\-]?[0-9]{2}[ \.\-]?[0-9]{2}[ \.\-]?[0-9]{2}[ \.\-]" placeholder="0605040302">
                                                    <input type="submit" value="OK">
                                            </div>
                                            <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-theme="b">Annuler</a>
                                            <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-transition="flow" data-theme="b">Modifier</a>
                                        </div>
                                </div>
                                <%---- btn de Suppression de véhicule-----%>
                                <a href="#BtnSupprL" data-rel="popup" data-position-to="window" data-transition="pop" class="ui-btn ui-corner-all ui-shadow
                                   ui-btn-inline ui-icon-delete ui-btn-i ui-btn-icon-left ui-btn-b"></a>
                                <div data-role="popup" id="BtnSupprL" data-overlay-theme="b" data-theme="b" data-dismissible="false">
                                    <div data-role="header" data-theme="b">
                                        <h1>Supprimer le Loueur ?</h1>
                                    </div>
                                    <div role="main" class="ui-content" >
                                        <h3 class="ui-title">Est vous sur de vouloir supprimer le Loueur ?</h3>
                                        <center>
                                            <label for="PLoueur" disabled="disabled"> Prénom:  Jean</label>
                                            <label for="NLoueur" disabled="disabled"> Nom:  Bon</label>
                                            <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-theme="b">Non</a>
                                            <a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-transition="flow" data-theme="b">Oui</a>
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