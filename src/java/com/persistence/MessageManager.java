/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.persistence;

import java.util.Timer;
import java.util.TimerTask;

/**
 *
 * @author Antoine PORTAL
 */
public class MessageManager {
    // definit le nombre de millis secondes dans un jour
    public static final long MILLIS_PAR_JOUR = 86400000;
    // constante du nombre de message maximum a envoyer sous 24H glissante
    public static final int NBR_MSG_MAX = 4;
    // compteur du nombre de message decendant envoyé
    private static int nbrMsgEnv = 0;
    // liste des timers
    private static Timer [] timers = {
        null, null, null, null
    };
    // nombre de timer actif
    private static int nbrTimer = 0;
    // message en cours d'attente d'envoie
    private static boolean msgAEnvoyer = false;
    // message a envoyer
    private static String msg = ""; 
    
    /*
     * param 1 msg : message a envoyé, 8 octets sous la forme hexadecimale 
     * Cette méthode est appeler pour une demande d'envoie d'un message 
     * descendant.
     * Elle retourne un boolean qui signifit si la demande est oui ou non
     * prise en compte.
     */
    public static boolean demandEnvoye (String msg) {
        if (msgAEnvoyer) return false;
        if (nbrMsgEnv < NBR_MSG_MAX) {
            nbrMsgEnv++;
            if (nbrTimer < NBR_MSG_MAX) {
                Timer t = new Timer ();
                t.schedule (new TimerTask () {
                    @Override
                    public void run() {
                        if (nbrMsgEnv > 0) nbrMsgEnv--;                 
                    }
                },
                MILLIS_PAR_JOUR,
                MILLIS_PAR_JOUR);
                timers [nbrTimer++] = t;
            }
            msgAEnvoyer = true;
            MessageManager.msg = msg;
            return true;
        }
        else return false;
    }
    
    /*
     * Cette méthode retourne le nombre de message envoyé, ce nombre peut
     * être compris entre 0 et 4
     */
    public static int getNbrMsgEnv () {
        return nbrMsgEnv;
    }
    
    /*
     * Cette méthode permet de savoir si un message est en cours
     * d'attente d'envoie
     */
    public static boolean isWaiting () {
        return msgAEnvoyer;
    }
    
    /*
     * Cette méthode renvoie le message qui est en attente, une fois cette 
     * méthode appeler, il est désormé possible de faire une nouvelle 
     * demande d'envoie.
     * Si seulement durant la journée, il y a eu moins de 4 envoies de message
     * descendant.
     */
    public static String getMsg () {
        msgAEnvoyer = false;
        return msg;
    }
    
}
