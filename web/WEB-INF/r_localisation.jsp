<%-- 
    Document   : localisation.jsp
    Description  : page localisation du parc pour le responsable
    Created on : Mars 2018
--%>

<%@page import="com.persistence.ZoneLimite"%>
<%@page import="com.persistence.DonneesTR"%>
<%@page import="com.persistence.Vehicule"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.persistence.ConnexionMySQL"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Accueil</title> 
        <%@ include file="/includes/header.jspf" %>
        <%-- force le rechargement du script (no cache) --%>
        <script type="text/javascript" src="js/map.js?ts=
            <% out.print(System.currentTimeMillis()); %>"
        >
        </script>
        <%-- appelle la function JS initialize --%>
        <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAteLjItiBvWdZJNOm97mU-jWaqtJ857Fc&callback=initialize"> </script>
    </head>
    <body>
        <% 
            Connection con = (Connection) session.getAttribute("con");
            if (con == null)
                con = ConnexionMySQL.newConnexion();
            session.setAttribute("con", con);
            ArrayList<String> immatriculations = Vehicule.getImmatriculations(con);
            ArrayList<Vehicule> lstVehicule = new ArrayList<>();
            ArrayList<DonneesTR> lstDtr = new ArrayList<>();
            for (int i=0;i<immatriculations.size();i++) {
                lstVehicule.add(Vehicule.getByImmatriculation(con, immatriculations.get(i)));
                lstDtr.add(DonneesTR.getLastByImmatriculation(con, lstVehicule.get(i).getImmatriculation()));
            }
        %>
        <div data-role="page" id="page1">
            <div class="header" data-role="header" data-id="main-header" data-tap-toggle="false" 
                 data-theme="a" data-position="fixed" data-fullscreen="true">
                  <h1>
                    <img id="logoHeader" src="images/alcisLogo.png"/>
                    Localisation  
                    
                    <form id="btnDeconnectionLocalisation" method="post" action="alfoxControl.jsp">
                        <input name="action" id="logout" type="hidden" value="logout"/>
                        <button type="submit" id="submitOK" name="submitOK">
                            <img id="white" src="css/themes/images/icons-png/power-white.png" >
                            <img id="black" src="css/themes/images/icons-png/power-black.png" >
                        </button>
                    </form>
                    
                </h1>
                <a href="#panelZones" 
                   class="ui-btn ui-btn-icon-notext ui-corner-all ui-icon-location ui-btn-left">
                </a>
                <a href="#panelVehicules" 
                   class="ui-btn ui-btn-icon-notext ui-corner-all ui-icon-bars ui-btn-right">
                </a>
            </div>
            
            <div role="main" class="ui-content">
                <br/><br/><br/>
                <div id="test1"></div>
                <div id="test2"></div>
                <!-- map google -->
                <div id="map"></div>
                <br/><br/><br/>
            </div>        
            <%@include file="/includes/footer.jspf" %>
          
        <!-- panel de zones -->
        <div id="panelZones" data-role="panel" data-position="left"  
            data-position-fixed="true" data-display="push">
            <ol id="listeZones" data-role="listview" data-icon="false">
                <li data-role="list-divider">Zones limites :</li>
                <%
                    ArrayList<ZoneLimite> lz = ZoneLimite.getLstZone(con);
                    for (int i = 0; i < lz.size(); i++) {
                        out.print("<li id=" + lz.get(i).getNom() + ">"
                                + "<a href='#'>" +  lz.get(i).getNom() + "</a>"
                                + "<input type='hidden' id='"
                                + lz.get(i).getNom() + "Zoom' value="
                                + lz.get(i).getZoom() + " />"
                                + "</li>");
                    }
                %>    
            </ol>
        </div>
        
        <!-- panel de véhicules -->
        <div id="panelVehicules" data-role="panel" data-position="right"  
                 data-position-fixed="true" data-display="push">
            <div data-role="collapsibleset" data-inset="false">
            <%
                for (int i=0;i<immatriculations.size();i++) {
                    String immat = lstVehicule.get(i).getImmatriculation();
                    out.print("<div data-role='collapsibleset' data-inset='false'>");
                    out.print("<div data-role='collapsible'>");
                    out.print("<h3>" + (i+1) + " : " + immat + "</h3>");
                    out.print("<ul data-role='listview' data-icon='false'>");
                    out.print("<li id=" + immat + " data-icon='false'><a href='#'>Centrer</a></li>");
                    out.print("<li id=" + immat + "Mode data-icon='false'>NORMAL</li>");
                    out.print("<li id=" + immat + "Compteur data-icon='false'>Compteur :  km</li>");
                    out.print("<li id=" + immat + "Conso data-icon='false'>ConsoMoy :  l</li>");
                    out.print("<li id=" + immat + "Vitesse data-icon='false'>VitMoy :  km/h</li>");
                    out.print("<li id=" + immat + "Regime data-icon='false'>RégimeMoy :  tpm</li>");
                    out.print("</div>");
                }
            %>   
            </div>
            </div>
        </div>
    </body>
</html>