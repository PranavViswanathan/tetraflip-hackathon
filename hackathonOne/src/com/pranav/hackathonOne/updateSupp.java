package com.pranav.hackathonOne;
import java.io.*;  
import java.lang.*;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;  
import javax.servlet.http.*;   

public class updateSupp extends HttpServlet {
	Thread th;
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
		response.setContentType("text/html");  
		PrintWriter out = response.getWriter();  
		 System.out.println("Here");         
		String n=request.getParameter("totalGrade");  
		String e=request.getParameter("supplierId");  
		
		
		try{  
			Class.forName("com.mysql.jdbc.Driver");

            //creating connection with the database
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hackathon","root","ganesh99");
            PreparedStatement ps = con.prepareStatement("update sup set totalGrade=? where supplierID=?");
			ps.setString(1,n);  
			ps.setString(2,e);  
			 
			
			int i=ps.executeUpdate();  
			
			out.print("You are successfully registered...");  
			Thread.sleep(3000);
			RequestDispatcher rs = request.getRequestDispatcher("end.html");
            rs.forward(request, response);
			      
			          
			} catch (Exception e2) {
				System.out.println(e2);
				}  
			          
			out.close();  
			}  
			  
}  


