import java.io.*;

public class WriteFile {
	public static void main(String[] args) {
		File file = new File(args[0]);	
		String	string;
		try {			
			PrintWriter out = new PrintWriter(new FileWriter(file));			
			String month;
			for(int i=1997;i<2016;i++){
				for(int j=1;j<13;j++){
					if (j<10){
						 month = "0"+Integer.toString(j);
					}else{
						 month = Integer.toString(j);
					}
					
					for(int k=10;k<=30;k+=10){
						string = Integer.toString(i)+"-"+month+"-"+Integer.toString(k);
						System.out.print(string+"\n");
						out.println(string+"\n");
					}
				}
			}									
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
