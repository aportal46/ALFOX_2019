/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function changeMode (type) {
    $.ajax({
        url: 'alfoxControl.jsp?action=r_modeBoitier',
        type: 'POST',
        data: {
            type: type
        },
        dataType: 'html',
        success: function (data) {
            $( "#test2" ).load( "r_infos #test2" );
        }
    });
}


