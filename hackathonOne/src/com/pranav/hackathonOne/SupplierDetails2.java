package com.pranav.hackathonOne;
import javax.servlet.ServletException;  
import java.io.*;  
import java.lang.*;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;  
import javax.servlet.http.*;  
public class SupplierDetails2 extends HttpServlet{
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
		response.setContentType("text/html");  
		PrintWriter out = response.getWriter();  
		 System.out.println("Here");         
		String sId=request.getParameter("supplierID");  
		String wFru=request.getParameter("whatFruit");  
		
		try{  
			Class.forName("com.mysql.jdbc.Driver");

            //creating connection with the database
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hackathon","root","ganesh99");
            PreparedStatement ps = con.prepareStatement("insert into sup(supplierID, whatFruit) values(?,?)");
			ps.setString(1,sId);  
			ps.setString(2,wFru);   
			
			int i=ps.executeUpdate();  
			
			out.print("You are successfully registered...");  
			Thread.sleep(3000);
			RequestDispatcher rs = request.getRequestDispatcher("functionality2.html");
            rs.forward(request, response);
			      
			          
			} catch (Exception e2) {
				System.out.println(e2);
				}  
			          
			out.close();  
			}  
			  
}  

