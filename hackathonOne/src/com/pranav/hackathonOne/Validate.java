package com.pranav.hackathonOne;

import java.sql.*;

public class Validate {
    public static boolean checkUser(String email,String pass) 
    {
        boolean st =false;
        try {

            //loading drivers for mysql
            Class.forName("com.mysql.jdbc.Driver");

            //creating connection with the database
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hackathon","root","ganesh99");
            PreparedStatement ps = con.prepareStatement("select email, pass from val where email=? and pass=?");
            String emailStripped = email.trim();
            String passStripped = pass.trim();
            ps.setString(1, emailStripped);
            ps.setString(2, passStripped);
            ResultSet rs =ps.executeQuery();
            st = rs.next();

        }
        catch(Exception e) {
            e.printStackTrace();
        }
        
        return st;        
        //return true;
    }   
}