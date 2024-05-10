package com.jwhh;

import java.io.IOException;
import java.io.Reader;
import java.io.Writer;

public class Main {

    public static void main(String[] args) {
	    doTryCatchFinally();
        //doTryWithResources();
        //doTryWithResourcesMulti();
        //doCloseThing();
    }

    public static void doTryCatchFinally() {
        char[] buff = new char[8];
        int length;
        Reader reader = null;
        try  {
            reader = Helper.openReader("file1.txt");
            while((length = reader.read(buff)) >= 0) {
                System.out.println("\nlength: " + length);
                for(int i=0; i < length; i++)
                    System.out.print(buff[i]);
            }
        } catch(IOException e) {
            System.out.println(e.getClass().getSimpleName() + " - " + e.getMessage());
        } finally {
            try {
                if (reader != null)
                    reader.close();
            } catch(IOException e2) {
                System.out.println(e2.getClass().getSimpleName() + " - " + e2.getMessage());
            }
        }
    }

    public static void doTryWithResources() {

    }

    public static void doTryWithResourcesMulti() {

    }

    private static void doCloseThing() {
        try(MyAutoCloseable ac = new MyAutoCloseable()) {
            ac.saySomething();
        } catch (IOException e) {
            System.out.println(e.getClass().getSimpleName() + " - " + e.getMessage());
        }
    }

}
