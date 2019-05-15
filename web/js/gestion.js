function deleteData (id, type) {
    $.ajax({
        url: 'alfoxControl.jsp?action=r_delete',
        type: 'POST',
        data: {
            id: id,
            type: type
        },
        dataType: 'html',
        success: function (data) {
            $( "#test2" ).load( "r_gestion #test2" );
        }
    });
}

const popupNvContrat = {
    CLoueur: "",
    MContrat: "",
    Cinfos: "",
    Cimmatriculation: "",
    CZoneLimite: "",
    init () {
        document.getElementById ("select-CLoueur").onchange = e => {
            this.CLoueur = e.target.value;
        };
        document.getElementById ("select-MContrat").onchange =e => {
            this.MContrat = e.target.value;
        };
        document.getElementById ("Cinfos").onchange = e => {
            this.Cinfos = e.target.value;
        };
        document.getElementById ("select-CImmatricualtion").onchange = e => {
            this.Cimmatriculation = e.target.value;
        };
        document.getElementById ("select-CZoneLimite").onchange = e =>  {
            this.CZoneLimite = e.target.value;
        };
    },
    creerContrat () {
        const that = this;
        $.ajax({
            url: 'alfoxControl.jsp?action=r_creerSection',
            type: 'POST',
            data: {
                type: "contrat",
                CLoueur: that.CLoueur,
                MContrat: that.MContrat,
                Cinfos: that.Cinfos,
                Cimmatriculation: that.Cimmatriculation,
                CZoneLimite: that.CZoneLimite
            },
            dataType: 'html',
            success: function (data) {
                $( "#test2" ).load( "r_gestion #test2" );
            }
        });
    }
};

const popupNvVehicule = {
    Immatriculation: "",
    Marque:"",
    VModele:"",
    dateCT:"",
    compteurR:"",
    Vdate:"",
    dateMiseService:"",
    Motorisation:"",
    init(){
        document.getElementById ("VImmatriculation").onchange = e => {
            this.Immatriculation = e.target.value;
        };
        document.getElementById ("VMarque").onchange = e => {
            this.Marque = e.target.value;
        };
        document.getElementById ("dateMiseService").onchange = e => {
            this.dateMiseService = e.target.value;
        };
        document.getElementById ("VModele").onchange = e => {
            this.VModele = e.target.value;
        };
        document.getElementById ("compteurR").onchange = e => {
            this.compteurR = e.target.value;
        };
        document.getElementById ("dateCT").onchange = e => {
            this.dateCT = e.target.value;
        };
         document.getElementById ("Vdate").onchange = e => {
            this.Vdate = e.target.value;
        };
        document.getElementById ("select-Motorisation").onchange = e => {
            this.Motorisation = e.target.value;
        };
    },
    creerVehicule(){
         const that = this;
        $.ajax({
            url: 'alfoxControl.jsp?action=r_creerSection',
            type: 'POST',
            data: {
                
                type: "vehicule",
                dateMiseService : that.dateMiseService,
                compteurR: that.compteurR,
                Immatriculation: that.Immatriculation,
                Marque: that.Marque,
                VModele: that.VModele,
                dateCT: that.dateCT,
                Vdate: that.Vdate,
                Motorisation: that.Motorisation
            },
            dataType: 'html',
            success: function (data) {
                $( "#test2" ).load( "r_gestion #test2" );
            }
        });
    }
};

const popupNvLoueur = {
    LPrenom: "",
    LNom:"",
    LEmail:"",
    phone:"",
    init(){
        document.getElementById ("LNom").addEventListener('input',e => {
            this.LNom = e.target.value;
        });
        document.getElementById ("LPrenom").addEventListener('input',e => {
            this.LPrenom = e.target.value;
        });  
        document.getElementById ("LEmail").addEventListener('input',e => {
            this.LEmail = e.target.value;
        });
        document.getElementById ("phone").addEventListener('input',e => {
            this.phone = e.target.value;
        });
    },
    creerLoueur(){ const that = this;
        $.ajax({
            url: 'alfoxControl.jsp?action=r_creerSection',
            type: 'POST',
            data: {
                type: "loueur",
                LPrenom: that.LPrenom,
                LNom: that.LNom,
                LEmail: that.LEmail,
                phone: that.phone
            },
            dataType: 'html',
            success: function (data) {
                $( "#test2" ).load( "r_gestion #test2" );
            }
        });
    }
};

function todaydate(){   
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0!
    var yyyy = today.getFullYear();

    if (dd < 10) {
        dd = '0' + dd;
    }

    if (mm < 10) {
        mm = '0' + mm;
    }
    today = yyyy + '/' + mm + '/' + dd;
    document.write(today);
}

const popupEditContrat = {
    init () {},
    EditContrat (numero) {
        const that = this;
        $.ajax({
            url: 'alfoxControl.jsp?action=r_EditSection',
            type: 'POST',
            data: {
                type: "contrat",
                infos: document.getElementById("infos" + numero).value,
                numero: numero,
                Immatriculation: document.getElementById ("select-Immatricualtion" + numero).value,
                ZoneLimite: document.getElementById ("select-ZoneLimite" + numero).value
            },
            dataType: 'html',
            success: function (data) {
                $( "#test2" ).load( "r_gestion #test2" );
            }
        });
    }
};

const popupEditVehicule = {
    init () {},
    EditVehicule (immatriculation) {
        const that = this;
        $.ajax({
            url: 'alfoxControl.jsp?action=r_EditSection',
            type: 'POST',
            data: {
                type: "vehicule",
                dateVid: document.getElementById("dateVid" + immatriculation).value,
                dateCT: document.getElementById ("dateCT" + immatriculation).value,
                Immatriculation: immatriculation
            },
            dataType: 'html',
            success: function (data) {
                $( "#test2" ).load( "r_gestion #test2" );
            }
        });
    }
};

const popupEditLoueur = {
    EditLoueur (id) {
        const that = this;
        $.ajax({
            url: 'alfoxControl.jsp?action=r_EditSection',
            type: 'POST',
            data: {
                type: "loueur",
                Email:  document.getElementById ("Email" + id).value,
                phone:  document.getElementById ("phone" + id).value,
                id : id
            },
            dataType: 'html',
            success: function (data) {
                $( "#test2" ).load( "r_gestion #test2" );
            }
        });
    }
};


window.onload = _ => {
    popupNvContrat.init();
    popupNvVehicule.init();
    popupNvLoueur.init();
    popupEditContrat.init ();
    popupEditVehicule.init ();
    console.log ("fin de chargement de la page html");
};