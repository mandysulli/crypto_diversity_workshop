import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;

public class reformat_Read_Counts {
	public static void main(String args[]) throws IOException {
		File text = new File(args[0]);
		String outputName = args[1]; 
		Scanner inFile = new Scanner(text);
		
		//Make array lists to store lines from sequence file in
		ArrayList<String> Line1 = new ArrayList<String>();
		ArrayList<String> Line2 = new ArrayList<String>();
		ArrayList<String> Line3 = new ArrayList<String>();
  		
		//Separating the lines(1-4) into different lists
    	int nLine = -1;
        while (inFile.hasNextLine()) {
		nLine++; 	
          String first = inFile.nextLine();
          Line1.add(nLine, first);
          String second = inFile.nextLine();
          Line2.add(nLine, second);
          String third = inFile.nextLine();
          Line3.add(nLine, third);
 
        }
        
        //Converting the lines in each list into arrays - array easier to work with when sorting
        String[] line1List = Line1.toArray(new String[Line1.size()]);
        String[] line2List = Line2.toArray(new String[Line2.size()]);
        String[] line3List = Line3.toArray(new String[Line3.size()]);
			//Checking that lists are correct below
        	//System.out.println(Arrays.toString(line1List));
        	//System.out.println(line1List.length);
            //System.out.println(Arrays.toString(line2List));
            //System.out.println(line2List.length);
            //System.out.println(Arrays.toString(line3List));
        	//System.out.println(line3List.length);
        
		/*String[][] finalMatrix = new String[line1List.length][3];
		finalMatrix[0][0]="Sample";
		finalMatrix[0][1]="Read1 Counts";
		finalMatrix[0][2]="Read2 Counts";
		
		for (int i =1; i<line1List.length;i++) {
			finalMatrix[i][0]= line1List[i];
		}
		for (int i =1; i<line2List.length;i++) {
			finalMatrix[i][1]= line2List[i];
		}
		for (int i =1; i<line3List.length;i++) {
			finalMatrix[i][2]= line3List[i];
		}
        
		//print
		for (int i =0; i <finalMatrix.length; i++){
			for (int j=0; j<finalMatrix[0].length; j++){
			System.out.print(finalMatrix[i][j]);
				if (j != finalMatrix[0].length-1){    
				System.out.print(", ");
				}
			}
			System.out.println("");  
		}*/
        
        //System.out.println(finalList);
        writeToFile(line1List, line2List, line3List, outputName);
		
}
	//Write the output to a file
	public static void writeToFile(String[] List1, String[] List2, String[] List3, String outputName) throws IOException{
		String[][] finalMatrix = new String[List1.length+1][3];
		finalMatrix[0][0]="Sample";
		finalMatrix[0][1]="Read1 Counts";
		finalMatrix[0][2]="Read2 Counts";
		
		for (int i =0; i<List1.length;i++) {
			finalMatrix[i+1][0]= List1[i];
		}
		for (int i =0; i<List2.length;i++) {
			finalMatrix[i+1][1]= List2[i];
		}
		for (int i =0; i<List3.length;i++) {
			finalMatrix[i+1][2]= List3[i];
		}
		
	    try {
	    FileWriter myWriter = new FileWriter(outputName);
		for (int i =0; i <finalMatrix.length; i++){
			for (int j=0; j<finalMatrix[0].length; j++){
				myWriter.write(finalMatrix[i][j].toString()+"	");
				}
			myWriter.write(System.lineSeparator());
			}
	        myWriter.close();
	    }
	    	finally{	
	    	}
	 } 
}