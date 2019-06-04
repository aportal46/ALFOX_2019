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
    
    public static int getNbrMsgEnv () {
        return nbrMsgEnv;
    }
    
    public static boolean isWaiting () {
        return msgAEnvoyer;
    }
    
    public static String getMsg () {
        msgAEnvoyer = false;
        return msg;
    }
}
