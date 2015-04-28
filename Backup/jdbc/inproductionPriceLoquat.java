import java.io.*;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class inproductionPriceLoquat {
	public static void main(String[] args) throws ParseException{			
		Connection conn = null;
		try{
			File inputfile = new File("C:\\Users\\BigData\\project\\Taichung_loquat-DAILY.csv");  //�i�ק�			
			String str;
			BufferedReader in = new BufferedReader(new FileReader(inputfile));
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			
			String connUrl = "jdbc:sqlserver://localhost:1433;databaseName=agriculture";
			conn = DriverManager.getConnection(connUrl, "sa", "passw0rd");
			String insStmt = "INSERT INTO loquat_production_price VALUES (?,?,?)";  //�i�ק�
			PreparedStatement pstmt = conn.prepareStatement(insStmt);
			
			while((str=in.readLine())!=null){
				String[] inputdata =str.split(",");				
				    
				    pstmt.setDate(1,new java.sql.Date((sdf.parse(inputdata[0])).getTime()));
				    pstmt.setDouble(2,Double.parseDouble(inputdata[1]));
				    pstmt.setDouble(3,Double.parseDouble(inputdata[2]));
				    pstmt.addBatch();
					System.out.print(inputdata[0]+" "+inputdata[1]+" "+inputdata[2]);					
				    System.out.print("\n");				  
					}pstmt.executeBatch();					
						
			
		}catch(IOException i){i.printStackTrace();}
		 catch(SQLException e){e.printStackTrace();} 
		 finally { 
		 if (conn != null)try {conn.close();}catch(SQLException e){e.printStackTrace();}
	}   
	}
}
