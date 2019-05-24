/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.persistence;

import java.sql.Connection;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.BeforeClass;

/**
 *
 * @author acros
 */
public class LoueurTest {

    @BeforeClass
    public static void setUpClass() throws Exception {
    }

    @AfterClass
    public static void tearDownClass() throws Exception {
    }

    @Before
    public void setUp() throws Exception {
    }

    @After
    public void tearDown() throws Exception {
    }

    /**
     * Test of create method, of class Loueur.
     * @throws java.lang.Exception
     */
    @Test
    public void testCreate() throws Exception {
        System.out.println("create");
        Connection con = ConnexionMySQL.newConnexion();
        Loueur result = Loueur.create(con, "Picasso", "Pablo", "0610090807", "pablopicasso@gmail.com");
        assertEquals("Picasso", result.getNom());
        result.delete(con);
    }

    /**
     * Test of save method, of class Loueur.
     * @throws java.lang.Exception
     */
    @Test
    public void testSave() throws Exception {
        System.out.println("save");
        Connection con = ConnexionMySQL.newConnexion();
        Loueur instance = Loueur.getByNom(con, "Magritte", "René");
        instance.setMail("nouveaumail@gmail.com");
        instance.save(con);
        instance = Loueur.getByNom(con, "Magritte", "René");
        assertEquals("nouveaumail@gmail.com", instance.getMail());
        instance.setMail("yvesmagritte@gmail.com");
        instance.save(con);
    }

    /**
     * Test of getByNom method, of class Loueur.
     * @throws java.lang.Exception
     */
    @Test
    public void testGetByNom() throws Exception {
        System.out.println("getByNom");
        Connection con = ConnexionMySQL.newConnexion();
        Loueur result = Loueur.getByNom(con, "Magritte", "René");
        assertEquals(1, result.getID(con));
    }

    /**
     * Test of getNom method, of class Loueur.
     * @throws java.lang.Exception
     */
    @Test
    public void testGetNom() throws Exception {
        System.out.println("getNom");
        Connection con = ConnexionMySQL.newConnexion();
        Loueur instance = Loueur.getByNom(con, "Magritte", "René");
        assertEquals("Magritte", instance.getNom());
    }

    /**
     * Test of getPrenom method, of class Loueur.
     * @throws java.lang.Exception
     */
    @Test
    public void testGetPrenom() throws Exception {
        System.out.println("getPrenom");
        Connection con = ConnexionMySQL.newConnexion();
        Loueur instance = Loueur.getByNom(con, "Magritte", "René");
        assertEquals("René", instance.getPrenom());
    }

    /**
     * Test of getTelephone method, of class Loueur.
     * @throws java.lang.Exception
     */
    @Test
    public void testGetTelephone() throws Exception {
        System.out.println("getTelephone");
        Connection con = ConnexionMySQL.newConnexion();
        Loueur instance = Loueur.getByNom(con, "Magritte", "René");
        assertEquals("0607080910", instance.getTelephone());
    }

    /**
     * Test of getMail method, of class Loueur.
     * @throws java.lang.Exception
     */
    @Test
    public void testGetMail() throws Exception {
        System.out.println("getMail");
        Connection con = ConnexionMySQL.newConnexion();
        Loueur instance = Loueur.getByNom(con, "Magritte", "Bernard");
        assertEquals("bernardmagritte@gmail.com", instance.getMail());
    }

    /**
     * Test of setTelephone method, of class Loueur.
     * @throws java.lang.Exception
     */
    @Test
    public void testSetTelephone() throws Exception {
        System.out.println("setTelephone");
        Connection con = ConnexionMySQL.newConnexion();
        Loueur instance = Loueur.getByNom(con, "Magritte", "René");
        instance.setTelephone("0606060606");
        instance.save(con);
        assertEquals("0606060606", instance.getTelephone());
        instance.setTelephone("0607080910");
        instance.save(con);
    }

    /**
     * Test of setMail method, of class Loueur.
     * @throws java.lang.Exception
     */
    @Test
    public void testSetMail() throws Exception {
        System.out.println("setMail");
        Connection con = ConnexionMySQL.newConnexion();
        Loueur instance = Loueur.getByNom(con, "Magritte", "René");
        instance.setMail("nouveaumail@gmail.com");
        instance.save(con);
        assertEquals("nouveaumail@gmail.com", instance.getMail());
        instance.setMail("yvesmagritte@gmail.com");
        instance.save(con);
    }

    /**
     * Test of getID method, of class Loueur.
     */
    @Test
    public void testGetID() throws Exception {
        System.out.println("getID");
        Connection con = ConnexionMySQL.newConnexion();
        Loueur loueur = Loueur.getByNom(con, "Bon", "Jean");
        assertEquals(4, loueur.getID(con));
        loueur = Loueur.getByNom(con, "Magritte", "René");
        assertEquals(1, loueur.getID(con));
        
    }
    
    /**
     * Test of size method, of class Loueur.
     */
    @Test
    public void testSize() throws Exception {
        System.out.println("size");
        Connection con = ConnexionMySQL.newConnexion();
        int result = Loueur.size(con);
        assertEquals(4, result);
    }

    /**
     * Test of getByID method, of class Loueur.
     */
    @Test
    public void testGetByID() throws Exception {
        System.out.println("getByID");
        Connection con = ConnexionMySQL.newConnexion();
        Loueur result = Loueur.getById(con, 1);
        assertEquals("Magritte", result.getNom());
    }
}