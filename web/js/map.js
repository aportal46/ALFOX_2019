
var markers = [];

// --------------------- callback ----------------------- 
$(function () {
    $("#listeZones li").on("click", centrerZone);
    $("#panelVehicules li").on("click", centrerVehicule);
    setInterval(updateMap, 10000);
});

function initialize() {
    map = new google.maps.Map(document.getElementById('map'), {
        zoom: 11,
        center: {lat: 43.601245, lng: 1.445555}
    });
    // on dessine toutesles zones limites
    dessineZones();
    createMap();
}

// mise à jour par ajax du tableau des vehicules avec les donnéesTR
// par destruction du tableau et reconstruction
function createMap() {
    $.ajax({
        url: 'alfoxControl.jsp?action=r_getVehiculesTR',
        type: 'POST',
        data: {},
        async: false,
        dataType: 'html',
        success: createMapAjaxCallback
    });
}

// mise à jour par ajax du tableau des vehicules avec les donnéesTR
// par destruction du tableau et reconstruction
function updateMap() {
    $.ajax({
        url: 'alfoxControl.jsp?action=r_getVehiculesTR',
        type: 'POST',
        data: {},
        async: false,
        dataType: 'html',
        success: updateMapAjaxCallback
    });
}

function createMapAjaxCallback(data) {
    var tabVehicules = data.split("##");
    var vehicules = [];
    for (i = 1; i < tabVehicules.length - 1; i++) {
        var vehiculeInfos = tabVehicules[i].split("||");
        vehicules.push({
            immatriculation : vehiculeInfos[0],
            mode : vehiculeInfos[1],
            nbDefauts : vehiculeInfos[2],
            latitude : vehiculeInfos[3],
            longitude : vehiculeInfos[4],
            distanceParcourue : vehiculeInfos[5],
            consommation : vehiculeInfos[6],
            vitesse : vehiculeInfos[7],
            regime : vehiculeInfos[8],
            latitudeGPS : vehiculeInfos[9],
            longitudeGPS : vehiculeInfos[10]
        });
    }
    createMarkers(vehicules);
    updatePanelVehicules(vehicules);
}

function updateMapAjaxCallback(data) {
    var tabVehicules = data.split("##");
    var vehicules = [];
    for (i = 1; i < tabVehicules.length - 1; i++) {
        var vehiculeInfos = tabVehicules[i].split("||");
        vehicules.push({
            immatriculation : vehiculeInfos[0],
            mode : vehiculeInfos[1],
            nbDefauts : vehiculeInfos[2],
            latitude : vehiculeInfos[3],
            longitude : vehiculeInfos[4],
            distanceParcourue : vehiculeInfos[5],
            consommation : vehiculeInfos[6],
            vitesse : vehiculeInfos[7],
            regime : vehiculeInfos[8],
            latitudeGPS : vehiculeInfos[9],
            longitudeGPS : vehiculeInfos[10]
        });
    }
    updateMarkers(vehicules);
    updatePanelVehicules(vehicules);
}

function createMarkers(vehicules) {
     for (i = 0; i < vehicules.length; i++) {
        var label = (i+1).toString();
        var immat = vehicules[i]['immatriculation'];
        var mode = getLabel(vehicules[i]['mode']);
        var couleur = getColor(vehicules[i]['mode']);
        
        var lat = Math.round(parseFloat(vehicules[i]['latitudeGPS']));
        var lg = Math.round(parseFloat(vehicules[i]['longitudeGPS']));
        var latitude, longitude;
        if ((lat == 0) && (lg == 0)) {
            latitude = vehicules[i]['latitude'];
            longitude = vehicules[i]['longitude'];
        }
        else {
            latitude = vehicules[i]['latitudeGPS'];
            longitude = vehicules[i]['longitudeGPS'];
        }
        // on crée un marqueur
        var marker = new google.maps.Marker({
            icon: {
                path: google.maps.SymbolPath.CIRCLE, scale: 12, 
                fillOpacity: 1, fillColor: couleur, strokeColor: couleur
            },
            position: new google.maps.LatLng(latitude, longitude),
            map: map,
            title: immat,
            label: {text:label, color:"white", fontWeight:"bold", fontSize:"18px"}
        });
        
        markers.push({
            immatriculation : immat,
            marqueur : marker
        });
    }
}

function updateMarkers(vehicules) {
    // $("#test2").html("resultat");
    for (i = 0; i < vehicules.length; i++) {
        var immat = vehicules[i]['immatriculation'];
        marker = findMarker(immat)['marqueur'];
        var couleur = getColor(vehicules[i]['mode']);
        var lat = Math.round(parseFloat(vehicules[i]['latitudeGPS']));
        var lg = Math.round(parseFloat(vehicules[i]['longitudeGPS']));
        var latitude, longitude;
        if ((lat == 0) && (lg == 0)) {
            latitude = vehicule [i]['latitude'];
            longitude = vehicule [i]['longitude'];
        }
        else {
            latitude = vehicule [i]['latitudeGPS'];
            longitude = vehicule [i]['longitudeGPS'];
        }
        marker.setPosition(new google.maps.LatLng(latitude, longitude));
        marker.setIcon({
                path: google.maps.SymbolPath.CIRCLE, scale: 12, 
                fillOpacity: 1, fillColor: couleur, strokeColor: couleur
            });
    }
}

function updatePanelVehicules(vehicules) {
    for (i = 0; i < vehicules.length; i++) {
        $("#" + vehicules[i]['immatriculation'] 
                            + "Compteur").html(vehicules[i]['distanceParcourue'] + " km");
        $("#" + vehicules[i]['immatriculation'] 
                            + "Mode").html(vehicules[i]['mode']);
        $("#" + vehicules[i]['immatriculation'] 
                            + "Conso").html(vehicules[i]['consommation'] + " l");
        $("#" + vehicules[i]['immatriculation'] 
                            + "Vitesse").html(vehicules[i]['vitesse'] + " km/h");
        $("#" + vehicules[i]['immatriculation'] 
                            + "Regime").html(vehicules[i]['regime'] + " tpm");
    }
}

function findMarker(immatriculation) {
    for (i = 0; i < markers.length; i++) {
        if (markers[i]['immatriculation'] === immatriculation)
            return markers[i];
    }
    return null;
} 

// Dessine les zones limites obtenues par ajax sur la map courante
// Même les zones non visibles sont ajoutées à la map
function dessineZones() {
    $.ajax({
        url: 'alfoxControl.jsp?action=r_getZones',
        type: 'POST',
        data: {},
        dataType: 'html',
        success: function (data) {
            var tabZones = data.split("##");
            // on n'affiche pas la zone Alcis
            var nb = tabZones.length - 1;
            for (i = 0; i < nb; i++) {
                var tabInfos = tabZones[i].split("||");
                var nom = tabInfos[1];
                var poly = new google.maps.Polyline({
                    strokeColor: '#FF0000',
                    strokeOpacity: 1.0,
                    strokeWeight: 2
                });
                poly.setMap(map);
                var path = poly.getPath();
                for (j = 2; j < tabInfos.length - 1; j = j + 2) {
                    path.push(new google.maps.LatLng(tabInfos[j], tabInfos[j+1]));
                }
                // la 1er coordonnée pour fermer le polygone
                path.push(new google.maps.LatLng(tabInfos[2], tabInfos[3]));
            }
        }
    });
}
 
function centrerVehicule() {
    var immatriculation = $(this).attr("id");

    marker = findMarker(immatriculation);
    newLat = parseFloat(marker['marqueur'].getPosition().lat());
    newLng = parseFloat(marker['marqueur'].getPosition().lng());
    map.setCenter({ lat : newLat, lng : newLng });
    map.setZoom(14);
    $("#panelVehicules").panel("close");
}

function centrerZone() {
    //alert($(this).attr("id"));
    var nomZone = $(this).attr("id");

    $.ajax({
        url: 'alfoxControl.jsp?action=r_getCenterByZoneName',
        type: 'POST',
        data: {zoneName: nomZone},
        dataType: 'html',
        success: function (data) {
            var tabInfos = data.split("||");
            newLat = parseFloat(tabInfos[1]);
            newLng = parseFloat(tabInfos[2]);
            map.setCenter({
		lat : newLat,
		lng : newLng
            });
            a = parseInt(document.getElementById(nomZone + "Zoom").value);
            map.setZoom(a);
            $("#panelZones").panel("close");
        }
    });
}
    
function getLabel(mode) {
    var label = 'N';
    switch (mode) {
        case ('GPS'):
        case ('DMD_GPS'):
            label = 'G';
            break;
        case 'INIT':
            label = 'I';
            break;
        case 'DEGRADE':
            label = 'D';
            break;
        case 'DORMIR':
            label = 'S';
            break;
    }
    return label;
}

function getColor(mode) {
    var color = 'green';
    switch (mode) {
        case ('GPS'):
        case ('DMD_GPS'):
            color = 'blue';
            break;
        case 'INIT':
            color = 'yellow';
            break;
        case 'DEGRADE':
            color = 'red';
            break;
        case 'DORMIR':
            color = 'black';
            break;
    }
    return color;
}

// affichage de test du tableau des vehicules dans la page r_localisation.jsp
function afficherTestVehicules(vehicules) {
    var resultat = "";
    for (i = 0; i < vehicules.length; i++) {
        resultat += "immatriculation : " + vehicules[i]['immatriculation'] + " ";
        resultat += "mode : " + vehicules[i]['mode'] + " ";
        resultat += "nbDefauts : " + vehicules[i]['nbDefauts'] + " ";
        resultat += "latitude : " + vehicules[i]['latitude'] + " ";
        resultat += "longitude : " + vehicules[i]['longitude'] + " ";
        resultat += "distanceParcourue : " + vehicules[i]['distanceParcourue'] + " ";
        resultat += "consommation : " + vehicules[i]['consommation'] + " ";
        resultat += "vitesse : " + vehicules[i]['vitesse'] + " ";
        resultat += "regime : " + vehicules[i]['regime'] + "<br/>";
    }
    $("#test1").html(resultat);
}
    