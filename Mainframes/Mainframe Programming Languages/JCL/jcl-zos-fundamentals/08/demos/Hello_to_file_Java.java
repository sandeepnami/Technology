package com.sample.java;

import java.io.BufferedReader;
import java.io.FileReader;

public class Hello {

	public int run(String infilePath) {
		if (null == infilePath || infilePath.length() < 1) {
			return 8;
		}
		try {
			String line;
			BufferedReader reader = 
			    new BufferedReader(new FileReader(infilePath));
			while ((line = reader.readLine()) != null) {
				System.out.println(line);
			}    
		} catch (Exception e) {
			return 12;
		}
		return 0;
	}

	public static void main(String[] args) {
		Hello app = new Hello();
		System.exit(app.run(args[0]));
	}
}