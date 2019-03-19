/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.persistence;

import java.sql.Connection;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author snir2g1
 */
public class BoitierTest {
    
    /**
     * Test of create method, of class Boitier.
     */
    @Test
    public void testCreate() throws Exception {
        System.out.println("create");
        Connection con = null;
        String SigfoxID = "";
        String ModeActuel = "";
        String ModeDemande = "";
        int NbMsgDownlink = 0;
        boolean CommValide = false;
        int VehiculeID = 0;
        Boitier expResult = null;
        Boitier result = Boitier.create(con, SigfoxID, ModeActuel, ModeDemande, NbMsgDownlink, CommValide, VehiculeID);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of save method, of class Boitier.
     */
    @Test
    public void testSave() throws Exception {
        System.out.println("save");
        Connection con = null;
        Boitier instance = null;
        instance.save(con);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of delete method, of class Boitier.
     */
    @Test
    public void testDelete() throws Exception {
        System.out.println("delete");
        Connection con = null;
        Boitier instance = null;
        boolean expResult = false;
        boolean result = instance.delete(con);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getByID method, of class Boitier.
     */
    @Test
    public void testGetByID() throws Exception {
        System.out.println("getByID");
        Connection con = null;
        String sigfoxID = "";
        Boitier expResult = null;
        Boitier result = Boitier.getByID(con, sigfoxID);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getByVehiculeID method, of class Boitier.
     */
    @Test
    public void testGetByVehiculeID() throws Exception {
        System.out.println("getByVehiculeID");
        Connection con = ConnexionMySQL.newConnexion();
        Boitier boitier = Boitier.getByVehiculeID(con, 1);
        assertEquals("1D2289", boitier.getSigfoxID());
        boitier = Boitier.getByVehiculeID(con, 2);
        assertEquals("1D188E", boitier.getSigfoxID());
    }

    /**
     * Test of getSigfoxID method, of class Boitier.
     */
    @Test
    public void testGetSigfoxID() {
        System.out.println("getSigfoxID");
        Boitier instance = null;
        String expResult = "";
        String result = instance.getSigfoxID();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getVehiculeID method, of class Boitier.
     */
    @Test
    public void testGetVehiculeID() {
        System.out.println("getVehiculeID");
        Boitier instance = null;
        int expResult = 0;
        int result = instance.getVehiculeID();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getModeActuel method, of class Boitier.
     */
    @Test
    public void testGetModeActuel() {
        System.out.println("getModeActuel");
        Boitier instance = null;
        String expResult = "";
        String result = instance.getModeActuel();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getModeDemande method, of class Boitier.
     */
    @Test
    public void testGetModeDemande() {
        System.out.println("getModeDemande");
        Boitier instance = null;
        String expResult = "";
        String result = instance.getModeDemande();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getNbMsgDownlink method, of class Boitier.
     */
    @Test
    public void testGetNbMsgDownlink() {
        System.out.println("getNbMsgDownlink");
        Boitier instance = null;
        int expResult = 0;
        int result = instance.getNbMsgDownlink();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getCommValide method, of class Boitier.
     */
    @Test
    public void testGetCommValide() {
        System.out.println("getCommValide");
        Boitier instance = null;
        boolean expResult = false;
        boolean result = instance.getCommValide();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setSigfoxID method, of class Boitier.
     */
    @Test
    public void testSetSigfoxID() throws Exception {
        System.out.println("setSigfoxID");
        String SigfoxID = "";
        Boitier instance = null;
        instance.setSigfoxID(SigfoxID);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setVehiculeID method, of class Boitier.
     */
    @Test
    public void testSetVehiculeID() throws Exception {
        System.out.println("setVehiculeID");
        int VehiculeID = 0;
        Boitier instance = null;
        instance.setVehiculeID(VehiculeID);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setModeActuel method, of class Boitier.
     */
    @Test
    public void testSetModeActuel() throws Exception {
        System.out.println("setModeActuel");
        String ModeActuel = "";
        Boitier instance = null;
        instance.setModeActuel(ModeActuel);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setModeDemande method, of class Boitier.
     */
    @Test
    public void testSetModeDemande() throws Exception {
        System.out.println("setModeDemande");
        String ModeDemande = "";
        Boitier instance = null;
        instance.setModeDemande(ModeDemande);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setNbMsgDownlink method, of class Boitier.
     */
    @Test
    public void testSetNbMsgDownlink() throws Exception {
        System.out.println("setNbMsgDownlink");
        int NbMsgDownlink = 0;
        Boitier instance = null;
        instance.setNbMsgDownlink(NbMsgDownlink);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setNCommValide method, of class Boitier.
     */
    @Test
    public void testSetNCommValide() throws Exception {
        System.out.println("setNCommValide");
        boolean CommValide = false;
        Boitier instance = null;
        instance.setNCommValide(CommValide);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of toString method, of class Boitier.
     */
    @Test
    public void testToString() {
        System.out.println("toString");
        Boitier instance = null;
        String expResult = "";
        String result = instance.toString();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }
    
}
