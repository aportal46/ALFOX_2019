/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.persistence;

/**
 *
 * @author snir2g1
 */
public class MessageSrv {
    public static final int NV_MODE = 0x30;
    public static enum Etat {VOID, NORMAL, DEGRADE, DMD_GPS, GPS, EC0,
                                    MAINTENANCE, RESET, INIT, SLEEP, DATA };
    public static enum DmdMode {MODE_STANDARD, DMD_GPS, MODE_GPS, MODE_EC0,
                                    MODE_MAINTENANCE, MODE_RESET, MODE_SLEEP, MODE_DATA, RIEN}; 
    
    private static String nouveauMode(int mode) {
        byte[] bMsg = {0,0,0,0,0,0,0,0};
        bMsg[0] = (byte) NV_MODE;
        bMsg[1] = (byte)mode;
        return new String(bMsg);
    }
    
    /*public static boolean envoyer(String idSigfox, int mode) {
        if (Sigfox.getNbrMsgEnv() < 4) {
            return Sigfox.envoyer(nouveauMode(mode));
        }
    }*/
}
