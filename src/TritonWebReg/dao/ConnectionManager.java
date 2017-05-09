package TritonWebReg.dao;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;

/**
 * Created by Saath_Ashish on 5/8/2017.
 */
public class ConnectionManager {
//    private static final String INIT_LOOOKUP = "java:comp/env";
//    private static final String DB_LOOKUP = "jdbc/sqlserver";
//
//    public static Connection con = null;
//
//    /**
//     * Creates a new ConnectionManager.  Getting an actual one should always be
//     * used with getConnection()
//     */
//    public ConnectionManager(){
//    }
//
//    /**
//     * Creates and returns a new Connection for a user
//     * @return - a connection to the database
//     */
//    public static Connection getConnection() {
//        try {
//            Context initContext = new InitialContext();
//            Context envContext = (Context) initContext.lookup(INIT_LOOOKUP);
//            DataSource ds = (DataSource) envContext.lookup(DB_LOOKUP);
//            con = ds.getConnection();
//            con.setAutoCommit(false);           // use transactions
//        } catch(Exception e) {
//            e.printStackTrace();
//        }
//        return con;
//    }
//
//    /**
//     * Closes the connection to the data base
//     * @param con - connection to close
//     */
//    public static void closeConnection(Connection con) {
//        try {
//            if(con != null) {
//                con.close();
//            }
//        } catch(Exception e) {
//            e.printStackTrace();
//        }
//    }

}
