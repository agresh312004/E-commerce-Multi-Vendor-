<%@ page import= "java.sql.*" %>
<%
    String s1=request.getParameter("N1") ;
    String s2=request.getParameter("N2") ; 
    try
    {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Seller?autoReconnect=true&useSSL=false","root","root");
      
      Statement st = con.createStatement();
     ResultSet rs =  st.executeQuery(" Select * from SRegister where Email_id='"+s1+"' and Password='"+s2+"' ");
     if(rs.next())
     {
       out.print("Data Finded");
     }
     else
     {
       out.print("Data not Finded");
     }
    }
    catch(Exception e)
    {
        out.print(e);
    }


%>