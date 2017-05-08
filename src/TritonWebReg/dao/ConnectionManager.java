package TritonWebReg.dao;

import java.sql.*;

/**
 * Created by Saath_Ashish on 5/8/2017.
 */
public class ConnectionManager {
    private static final String INIT_LOOOKUP = "java:comp/env";
    public static Connection conn = null;

    /**
     * Creates a new ConnectionManager.  Getting an actual one should always be
     * used with getConnection()
     */
    public ConnectionManager(){
    }

    /**
     * Closes the connection to the data base
     * @param con - connection to close
     */
    public static void closeConnection(Connection con) {
        try {
            if(con != null) {
                con.close();
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

}
