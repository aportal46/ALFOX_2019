<%-- 
    Document   : maintenance.jsp
    Description  : page maintenance
    Created on : Mars 2018
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Acceuil</title> 
        <%@ include file="/includes/header.jspf" %>
    </head>
    <body>
        <div data-role="page" id="page1">
            <div class="header" data-role="header" data-id="main-header" data-tap-toggle="false" 
                 data-theme="a" data-position="fixed" data-fullscreen="true">
                 <h1>
                    <img id="logoHeader" src="images/alcisLogo.png"/>
                    Maintenance  
                    
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
                    <h1>Page de maintenance</h1>
                    <br/><br/><br/>
                </center>
            </div>        
            <%@include file="/includes/footer.jspf" %>
        </div>
    </body>
</html>